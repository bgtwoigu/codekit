#! perl
#
# Example script to connect into Atom feed after authentication
# Usage: perl feed_parser.pl <username> <password> <atom_feed_url>
# Example URL: "https://chipcode.qti.qualcomm.com/projects/<mycompany>_apq8064-la-1-41_adsp_oem_hap/repository/revisions.atom?key=<your_key>" 
# URL Can also be copied and pasted from the Atom feed link at the bottom
# of any project
#
#

use strict;
use LWP;
use HTTP::Cookies;
use LWP::Authen::Basic;
use Data::Dumper;
use WWW::Mechanize;
my $username = $ARGV[0];
my $password = $ARGV[1];
my $feed_uri = $ARGV[2];
$ENV{'PERL_LWP_SSL_VERIFY_HOSTNAME'} = 0;
# Create a cookie jar to store cookies
my $cookie_jar = HTTP::Cookies->new(
  file => "$ENV{'HOME'}/lwp_cookies.dat",
  autosave => 1,
);
my $mech = WWW::Mechanize->new(cookie_jar => $cookie_jar);

#### Set up UA #####
my %options = {};
my $ua = LWP::UserAgent->new( %options );
#$ua->agent('Mozilla/5.0');
$ua->cookie_jar($cookie_jar);
push @{ $ua->requests_redirectable }, 'POST';
#### END Set up UA #####

sub ack_me {
    $mech->get("http://qtiack12.qti.qualcomm.com/ack/agreement/review?referer=https://chipcode.qti.qualcomm.com/");
    $mech->form_name('ackForm');
    my $button = $mech->current_form()->find_input( undef, 'submit' );
    $mech->click($button->{'_action_cont'});
}

# print "Connecting to $feed_uri\n";

ack_me;

my $request = HTTP::Request->new(GET => $feed_uri);
my $get_response = $ua->request($request);
# print "RESPONSE: $get_response->{'content'}";

# Get the realm
my $realm = $get_response->{'_headers'}->{'www-authenticate'};

# Parse out the real realm
(undef, $realm) = split(/=/,$realm);
# print "Realm: $realm\n";

# Add the login info to the UA
$ua->credentials( $get_response->{'_headers'}->{'client-peer'}, $realm, $username, $password );

# Here we are going to get bounced out to the redirected URL
# print $get_response->headers()->as_string;
my $bounce_url = $get_response->request->uri;

# print "Redirected URL: ", $bounce_url, "\n";
my $auth_get_request = HTTP::Request->new(GET => $bounce_url);

# Add in some basic auth
$auth_get_request->authorization_basic($username, $password);

# Create the new request
my $auth_get_response = $ua->request($auth_get_request);

# Now we have our feed to pipe through an ATOM feed parser
my $atom_feed = $auth_get_response->content;

# print "Atom Feed: ", $atom_feed, "\n";
print $atom_feed;

exit;
