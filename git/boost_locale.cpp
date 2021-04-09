#include <boost/locale.hpp>
#include <iostream>
#include <time.h>

using namespace std;
using namespace boost::locale;

int main()
{
  generator gen;

  // Specify location of dictionaries
  gen.add_messages_path( "." );
  gen.add_messages_domain( "hello/utf-8" );

  {
    std::locale loc( gen( "en_US.UTF-8" ) );
    
    locale::global( loc );
    cout.imbue( locale() );
    
    cout << translate( "Hello World" ) << endl;
    
    cout << std::use_facet< boost::locale::info >( loc ).name() << endl;
    cout << std::use_facet< boost::locale::info >( loc ).language() << endl;
    cout << std::use_facet< boost::locale::info >( loc ).country() << endl;
    cout << std::use_facet< boost::locale::info >( loc ).variant() << endl;
    cout << std::use_facet< boost::locale::info >( loc ).encoding() << endl;
    
    cout << boost::locale::as::date << time(0) << std::ends;
  }
    
  return 0;
}
