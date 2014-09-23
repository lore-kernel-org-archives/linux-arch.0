From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: bit fields && data tearing
Date: Tue, 23 Sep 2014 19:39:55 +0100
Message-ID: <20140923193955.2fb9cb14@alan.etchedpixels.co.uk>
References: <20140712181328.GA8738@redhat.com>
 <54079B70.4050200@hurleysoftware.com>
 <1409785893.30640.118.camel@pasglop>
 <063D6719AE5E284EB5DD2968C1650D6D17487172@AcuExch.aculab.com>
 <1409824374.4246.62.camel@pasglop> <5408E458.3@zytor.com>
 <54090AF4.7060406@hurleysoftware.com> <54091B30.7080100@zytor.com>
 <5409D76D.2070203@hurleysoftware.com> <5409D9C0.7030403@zytor.com>
 <20140908185240.21f52ca0@alan.etchedpixels.co.uk>
 <540DEE6C.2060904@zytor.com> <540E3207.7090007@hurleysoftware.com>
 <20140911110411.2de01944@alan.etchedpixels.co.uk>
 <5411FFB6.2080702@hurleysoftware.com>
 <20140915002427.6ce18965@alan.etchedpixels.co.uk>
 <5421B9A6.5020408@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <5421B9A6.5020408@hurleysoftware.com>
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
Cc: Jakub Jelinek <jakub@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, linux-alpha@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Laight <David.Laight@ACULAB.COM>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: linux-arch.vger.kernel.org

PiA+IFllcyAtIGJlY2F1c2UgaWYgeW91IHRoaW5rIGFib3V0IGl0IHRoYXQgdGVsbHMgeW91IHRo
YXQgbm9ib2R5IGlzIGhpdHRpbmcKPiA+IGl0IHdpdGggdGhlIG9sZCBjb2RlIGFuZCBpdCBwcm9i
YWJseSBkb2Vzbid0IG1hdHRlci4KPiAKPiBJIGRvbid0IHVuZGVyc3RhbmQgdGhpcyByZXBseS4K
Ckl0J3MgYSBtYXR0ZXIgb2YgcHJpb3JpdGllcy4gVGhlcmUgYXJlIGh1bmRyZWRzIG9mIHBvdGVu
dGlhbCBzZWN1cml0eQpob2xlcyB0dXJuZWQgdXAgYnkgc2Nhbm5lcnMsIDIsNTAwKyBmaWxlZCBi
dWdzIGluIGtlcm5lbCBidWd6aWxsYSBhbG9uZS4KCldoaWNoIG1hdHRlcnMgbW9yZSAtIGZpeGlu
ZyB0aGUgYnVncyBwZW9wbGUgaGl0IG9yIHRoZSBvbmVzIHRoYXQgdGhleQpkb24ndCBhbmQgd2hp
Y2ggaGF2ZSBhIHZlcnkgaGlnaCBjb3N0IGltcGFjdCBvbiBvdGhlciB1c2VycyA/Cgo+IExpa2V3
aXNlLCBJJ20gcG9pbnRpbmcgdGhhdCBieXRlLXNpemVkIGNpcmN1bGFyIGJ1ZmZlcnMgd2lsbCBh
bHNvIGJlIAo+IGNvcnJ1cHRlZCB1bmRlciBjZXJ0YWluIGNpcmN1bXN0YW5jZXMgKHdoZW4gdGhl
IGhlYWQgY29tZXMgbmVhciB0aGUgdGFpbCkuCgpZZXMuIEkgYmVsaWV2ZSB0aGUgY2xhc3NpYyB3
b3JkaW5nIGlzICJ0aGlzIHByb2JsZW0gaGFzIG5vdCBiZWVuIG9ic2VydmVkCmluIHRoZSBmaWVs
ZCIKIAo+IDIuIEknbSBub3Qgc3VyZSB3aGVyZSB5b3UgYXJyaXZlZCBhdCB0aGUgY29uY2x1c2lv
biB0aGF0IHNldF9iaXQoKSBldC5hbC4gaXMKPiBmYXN0IG9uIHg4Ni4gQmVzaWRlcyB0aGUgaGVh
dnktZHV0eSBpbnN0cnVjdGlvbnMgKGxnZHQsIG1vdiBjcjAsIGV0YyksIHRoZQo+IGJ1cy1sb2Nr
ZWQgYml0IGluc3RydWN0aW9ucyBhcmUgYW1vbmcgdGhlIG1vc3QgZXhwZW5zaXZlIGluc3RydWN0
aW9ucyBpbiB0aGUKPiBrZXJuZWwuCgo+IEkndmUgYXR0YWNoZWQgYSBzbW9rZSB0ZXN0IEkgdXNl
IGZvciBsaWdodHdlaWdodCB2YWxpZGF0aW9uIG9mIHB0eSBzbGF2ZSByZWFkcy4KPiBJZiB5b3Ug
cnVuIHRoaXMgc21va2UgdGVzdCB1bmRlciBwZXJmLCBhbG1vc3QgZXZlcnkgaGlnaC12YWx1ZSBo
aXQgaXMgYQo+IGJ1cy1sb2NrZWQgYml0IGluc3RydWN0aW9uLiBDaGVjayBvdXQgY2Fub25fY29w
eV9mcm9tX3JlYWRfYnVmKCkgd2hpY2ggcGVyZm9ybXMKPiB0aGUgYWN0dWFsIGNvcHkgb2YgZGF0
YSBmcm9tIHRoZSBsaW5lIGRpc2NpcGxpbmUgaW5wdXQgYnVmZmVyIHRvIHRoZSBfX3VzZXIKPiBi
dWZmZXI7IHRoZSBjbGVhcl9iaXQoKSBpcyB0aGUgcGVyZm9ybWFuY2UgaGl0LiBDaGVjayBvdXQg
Y3B1X2lkbGVfbG9vcCgpLi4uCgpBbmQgdGhlbiBnbyBhbmQgaW5zdHJ1bWVudCB3aGV0aGVyIGl0
cyB0aGUgYml0IGluc3RydWN0aW9ucyBvciB0aGUgY2FjaGUKbWlzc2VzID8KCgpJZiB0aGVyZSBp
cyBhIHNpZ25pZmljYW50IHBlcmZvcm1hbmNlIGltcHJvdmVtZW50IGJ5IHNwYWNpbmcgdGhlIGZp
ZWxkcwpjYXJlZnVsbHksIGFuZCB5b3UgZG9uJ3QgaGF2ZSBvdGhlciBvcmRlcmluZyBwcm9ibGVt
cyBhcyBhIHJlc3VsdAoocmVtZW1iZXJpbmcgdGhhdCB0aGUgY29tcGlsZXIgaGFzIGEgbG90IG9m
IHJlLW9yZGVyaW5nIG9wdGlvbnMgcHJvdmlkZWQKdGhlIHJlLW9yZGVyaW5nIGNhbm5vdCBiZSBv
YnNlcnZlZCkKCklmIHRoYXQncyB0aGUgY2FzZSB0aGVuIGZpbmUgLSBzdWJtaXQgYSBwYXRjaCB3
aXRoIG51bWJlcnMgYW5kIHRoZSBmaWVsZHMKc3BhY2VkIGFuZCBxdW90ZSB0aGUgcGVyZm9ybWFu
Y2UgZGF0YS4KCkFsYW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXhwcGMtZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJz
Lm9yZwpodHRwczovL2xpc3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2
