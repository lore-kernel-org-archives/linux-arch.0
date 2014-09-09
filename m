From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: bit fields && data tearing
Date: Mon, 08 Sep 2014 19:27:14 -0700
Message-ID: <540E6582.9020403@zytor.com>
References: <21512.10628.412205.873477@gargle.gargle.HOWL>			
 <20140904090952.GW17454@tucnak.redhat.com>			
 <540859EC.5000407@hurleysoftware.com>			
 <20140904175044.4697aee4@alan.etchedpixels.co.uk>			
 <5408C0AB.6050801@hurleysoftware.com>			
 <20140905001751.GL5001@linux.vnet.ibm.com>			
 <1409883098.5078.14.camel@jarvis.lan>		
 <5409243C.4080704@hurleysoftware.com>			
 <20140905040645.GO5001@linux.vnet.ibm.com>			
 <1410066442.12512.13.camel@jarvis.lan>			
 <20140907162146.GK5001@linux.vnet.ibm.com>		
 <1410116687.2027.19.camel@jarvis.lan>	 <540CC305.8010407@hurleysoftware.com>
 <1410155407.2027.29.camel@jarvis.lan>	 <540E1587.3060108@tilera.com>
 <1410216228.2027.88.camel@jarvis.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1410216228.2027.88.camel@jarvis.lan>
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
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Chris Metcalf <cmetcalf@tilera.com>
Cc: Jakub Jelinek <jakub@redhat.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Mikael Pettersson <mikpelinux@gmail.com>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: linux-arch.vger.kernel.org

T24gMDkvMDgvMjAxNCAwMzo0MyBQTSwgSmFtZXMgQm90dG9tbGV5IHdyb3RlOgo+IAo+IFRoaXMg
d2FzIHllYXJzIGFnbyAocG9zc2libHkgZGVjYWRlcykuICBXZSBoYWQgdG8gaW1wbGVtZW50IGlu
LWtlcm5lbAo+IHVuYWxpZ25lZCB0cmFwcyBmb3IgdGhlIG5ldHdvcmtpbmcgbGF5ZXIgYmVjYXVz
ZSBpdCBjb3VsZCBhY2Nlc3Mgc2hvcnQKPiBhbmQgaW50IGZpZWxkcyB0aGF0IHdlcmVuJ3Qgb2Yg
dGhlIGNvcnJlY3QgYWxpZ25tZW50IHdoZW4gcHJvY2Vzc2luZwo+IHBhY2tldHMuICBJdCB0aGF0
J3MgYWxsIGNvcnJlY3RlZCBub3csIHdlIHdvdWxkbid0IHJlYWxseSBub3RpY2UgKGV4Y2VwdAo+
IGEgYml0IG9mIGEgc3BlZWQgdXAgc2luY2UgYW4gdW5hbGlnbmVkIHRyYXAgZWZmZWN0aXZlbHkg
cGxhY2VzIHRoZQo+IGJyb2tlbiBvdXQgaW5zdHJ1Y3Rpb25zIGludG8gdGhlIGJpdCBzdHJlYW0p
Lgo+IAo+IEphbWVzCj4gCgpXZWxsLCBBUk0gZG9lc24ndCB0cmFwLCBpdCBqdXN0IHNpbGVudGx5
IGdpdmVzIGdhcmJhZ2Ugb24gdW5hbGlnbmVkCm1lbW9yeSByZWZlcmVuY2VzLgoKCS1ocGEKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eHBwYy1k
ZXYgbWFpbGluZyBsaXN0CkxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnCmh0dHBzOi8vbGlz
dHMub3psYWJzLm9yZy9saXN0aW5mby9saW51eHBwYy1kZXY=
