From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: bit fields && data tearing
Date: Fri, 5 Sep 2014 13:09:26 -0700
Message-ID: <20140905200926.GW5001@linux.vnet.ibm.com>
References: <063D6719AE5E284EB5DD2968C1650D6D17487172@AcuExch.aculab.com>
 <1409824374.4246.62.camel@pasglop> <5408E458.3@zytor.com>
 <54090AF4.7060406@hurleysoftware.com> <54091B30.2090509@zytor.com>
 <20140905081648.GB5281@omega>
 <20140905180950.GU5001@linux.vnet.ibm.com>
 <540A05F7.1070202@hurleysoftware.com>
 <20140905190506.GV5001@linux.vnet.ibm.com>
 <540A0DF3.8030802@hurleysoftware.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <540A0DF3.8030802@hurleysoftware.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Jakub Jelinek <jakub@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Michael Cree <mcree@orcon.net.nz>, linux-alpha@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Laight <David.Laight@ACULAB.COM>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: linux-arch.vger.kernel.org

T24gRnJpLCBTZXAgMDUsIDIwMTQgYXQgMDM6MjQ6MzVQTSAtMDQwMCwgUGV0ZXIgSHVybGV5IHdy
b3RlOgo+IE9uIDA5LzA1LzIwMTQgMDM6MDUgUE0sIFBhdWwgRS4gTWNLZW5uZXkgd3JvdGU6Cj4g
PiBPbiBGcmksIFNlcCAwNSwgMjAxNCBhdCAwMjo1MDozMVBNIC0wNDAwLCBQZXRlciBIdXJsZXkg
d3JvdGU6Cj4gPj4gT24gMDkvMDUvMjAxNCAwMjowOSBQTSwgUGF1bCBFLiBNY0tlbm5leSB3cm90
ZToKPiAKPiBbY3V0XQo+IAo+ID4+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+Pj4KPiA+Pj4gZG9jdW1l
bnRhdGlvbjogUmVjb3JkIGxpbWl0YXRpb25zIG9mIGJpdGZpZWxkcyBhbmQgc21hbGwgdmFyaWFi
bGVzCj4gPj4+Cj4gPj4+IFRoaXMgY29tbWl0IGRvY3VtZW50cyB0aGUgZmFjdCB0aGF0IGl0IGlz
IG5vdCBzYWZlIHRvIHVzZSBiaXRmaWVsZHMgYXMKPiA+Pj4gc2hhcmVkIHZhcmlhYmxlcyBpbiBz
eW5jaHJvbml6YXRpb24gYWxnb3JpdGhtcy4gIEl0IGFsc28gZG9jdW1lbnRzIHRoYXQKPiA+Pj4g
Q1BVcyBtdXN0IHByb3ZpZGUgb25lLWJ5dGUgYW5kIHR3by1ieXRlIGxvYWQgYW5kIHN0b3JlIGlu
c3RydWN0aW9ucwo+ID4+ICAgICAgICAgICAgICAgICAgICBeCj4gPj4gICAgICAgICAgICAgICAg
IGF0b21pYwo+ID4gCj4gPiBIZXJlIHlvdSBtZWFudCBub24tYXRvbWljPyAgTXkgZ3Vlc3MgaXMg
dGhhdCB5b3UgYXJlIHJlZmVycmluZyB0byB0aGUKPiA+IGZhY3QgdGhhdCB5b3UgY291bGQgZW11
bGF0ZSBhIG9uZS1ieXRlIHN0b3JlIG9uIHByZS1FVjU2IEFscGhhIENQVXMKPiA+IHVzaW5nIHRo
ZSBsbCBhbmQgc2MgYXRvbWljLXJlYWQtbW9kaWZ5LXdyaXRlIGluc3RydWN0aW9ucywgY29ycmVj
dD8KPiAKPiBZZXMsIHRoYXQncyB3aGF0IEkgbWVhbnQuIEkgbXVzdCBiZSB0aXJlZCBhbmQgYW0g
bWlzcmVhZGluZyB0aGUgY29tbWl0Cj4gbWVzc2FnZSwgb3IgbWlzaW50ZXJwcmV0aW5nIGl0J3Mg
bWVhbmluZy4KClZlcnkgZ29vZCwgZ290IGl0IQoKCQkJCQkJCVRoYW54LCBQYXVsCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eHBwYy1kZXYgbWFp
bGluZyBsaXN0CkxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnCmh0dHBzOi8vbGlzdHMub3ps
YWJzLm9yZy9saXN0aW5mby9saW51eHBwYy1kZXY=
