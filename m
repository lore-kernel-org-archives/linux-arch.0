From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: bit fields && data tearing
Date: Mon, 08 Sep 2014 12:12:50 -0700
Message-ID: <540DFFB2.4000509@zytor.com>
References: <5408C0AB.6050801@hurleysoftware.com>		
 <20140905001751.GL5001@linux.vnet.ibm.com>		
 <1409883098.5078.14.camel@jarvis.lan>	
 <5409243C.4080704@hurleysoftware.com>		
 <20140905040645.GO5001@linux.vnet.ibm.com>		
 <1410066442.12512.13.camel@jarvis.lan>		
 <20140907162146.GK5001@linux.vnet.ibm.com>		
 <1410116687.2027.19.camel@jarvis.lan>		
 <20140907230019.GO5001@linux.vnet.ibm.com>		
 <6092b453-e0c9-4f6d-922b-48bce988f774@email.android.com>		
 <20140907233655.GR5001@linux.vnet.ibm.com>		
 <154b540a-df47-4f3e-bdda-ab5d2e72723a@email.android.com>	
 <1410155802.2027.36.camel@jarvis.lan> <540DF17C.9080509@zytor.com>
 <1410203369.2027.56.camel@jarvis.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1410203369.2027.56.camel@jarvis.lan>
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
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jakub Jelinek <jakub@redhat.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Mikael Pettersson <mikpelinux@gmail.com>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: linux-arch.vger.kernel.org

T24gMDkvMDgvMjAxNCAxMjowOSBQTSwgSmFtZXMgQm90dG9tbGV5IHdyb3RlOgo+IAo+IFVtLCBJ
IHRoaW5rIHlvdSBuZWVkIHRvIHJlLXJlYWQgdGhlIHRocmVhZDsgdGhhdCdzIG5vdCB3aGF0IEkg
c2FpZCBhdAo+IGFsbC4gSXQncyBldmVuIHdyaXR0ZW4gbG93ZXIgZG93bjogIlBBIGNhbid0IGRv
IGF0b21pYyBiaXQgc2V0cyAobm8KPiBhdG9taWMgUk1XIGV4Y2VwdCB0aGUgbGRjdyBvcGVyYXRp
b24pIGl0IGNhbiBkbyBhdG9taWMgd3JpdGVzIHRvCj4gZnVuZGFtZW50YWwgc2l6ZXMgKGJ5dGUs
IHNob3J0LCBpbnQsIGxvbmcpIHByb3ZpZGVkIGdjYyBlbWl0cyB0aGUKPiBjb3JyZWN0IHByaW1p
dGl2ZSIuICBUaGUgb3JpZ2luYWwgcXVlc3Rpb24gd2FzIHdoZXRoZXIgYXRvbWljaXR5Cj4gcmVx
dWlyZWQgbmF0aXZlIGJ1cyB3aWR0aCBhY2Nlc3MsIHdoaWNoIHdlIGN1cnJlbnRseSBhc3N1bWUs
IHNvIHRoZXJlJ3MKPiBubyBleHRhbnQgcHJvYmxlbS4KPiAKClRoZSBpc3N1ZSBhdCBoYW5kIHdh
cyB3aGV0aGVyIG9yIG5vdCBwYXJ0aWFsbHkgb3ZlcmxhcHBlZCAoYnV0IG5hdHVhbGx5CmFsaWdu
ZWQpIHdyaXRlcyBjYW4gcGFzcyBlYWNoIG90aGVyLiAgKlRoaXMqIGlzIHRoZSBhZ2dyZXNzaXZl
CnJlbGF4YXRpb24gdG8gd2hpY2ggSSBhbSByZWZlcnJpbmcuCgpJIHdvdWxkIGd1ZXNzIHRoYXQg
dGhhdCBpcyBhIHZlcnkgdW51c3VhbCBjb25zdHJhaW50LgoKCS1ocGEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4cHBjLWRldiBtYWlsaW5nIGxp
c3QKTGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcKaHR0cHM6Ly9saXN0cy5vemxhYnMub3Jn
L2xpc3RpbmZvL2xpbnV4cHBjLWRldg==
