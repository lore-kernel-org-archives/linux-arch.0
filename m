From: Joe Perches <joe@perches.com>
Subject: Re: rfc: remove print_vma_addr ? (was Re: [PATCH 00/16] remove
 eight obsolete architectures)
Date: Thu, 15 Mar 2018 10:13:42 -0700
Message-ID: <1521134022.22221.38.camel@perches.com>
References: <20180314143529.1456168-1-arnd@arndb.de>
 <2929.1521106970@warthog.procyon.org.uk>
 <CAMuHMdXcxuzCOnFCNm4NXDv-wfYJDO5GQpB_ECu7j=2BjMhNpA@mail.gmail.com>
 <1521133006.22221.35.camel@perches.com>
 <20180315170830.GA17574@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180315170830.GA17574@bombadil.infradead.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-block@vger.kernel.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org, netdev <netdev@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-ide@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, DRI Development <dri-devel@lists.freedesktop.org>, linux-input@vger.kernel.org, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-rtc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

T24gVGh1LCAyMDE4LTAzLTE1IGF0IDEwOjA4IC0wNzAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToK
PiBPbiBUaHUsIE1hciAxNSwgMjAxOCBhdCAwOTo1Njo0NkFNIC0wNzAwLCBKb2UgUGVyY2hlcyB3
cm90ZToKPiA+IEkgaGF2ZSBhIHBhdGNoc2V0IHRoYXQgY3JlYXRlcyBhIHZzcHJpbnRmIGV4dGVu
c2lvbiBmb3IKPiA+IHByaW50X3ZtYV9hZGRyIGFuZCByZW1vdmVzIGFsbCB0aGUgdXNlcyBzaW1p
bGFyIHRvIHRoZQo+ID4gcHJpbnRfc3ltYm9sKCkgcmVtb3ZhbC4KPiA+IAo+ID4gVGhpcyBub3cg
YXZvaWRzIGFueSBwb3NzaWJsZSBwcmludGsgaW50ZXJsZWF2aW5nLgo+ID4gCj4gPiBVbmZvcnR1
bmF0ZWx5LCB3aXRob3V0IHNvbWUgI2lmZGVmIGluIHZzcHJpbnRmLCB3aGljaAo+ID4gSSB3b3Vs
ZCBsaWtlIHRvIGF2b2lkLCBpdCBpbmNyZWFzZXMgdGhlIG5vbW11IGtlcm5lbAo+ID4gc2l6ZSBi
eSB+NTAwIGJ5dGVzLgo+ID4gCj4gPiBBbnlvbmUgdGhpbmsgdGhpcyBpcyBhY2NlcHRhYmxlPwpb
XQo+IFRoaXMgZG9lc24ndCBmZWVsIGxpa2UgYSBodWdlIHdpbiBzaW5jZSBpdCdzIG9ubHkgY2Fs
bGVkIH5vbmNlIHBlcgo+IGFyY2hpdGVjdHVyZS4gIEknZCBiZSBtb3JlIGV4Y2l0ZWQgaWYgaXQg
bWFkZSB0aGUgcHJpbnRpbmcgb2YgdGhlIHdob2xlCj4gdGhpbmcgc3RhbmRhcmRpc2VkOyBlZyB3
ZSBoYXZlIGEgcHJpbnRfZmF1bHQoKSBmdW5jdGlvbiBpbiBtbS9tZW1vcnkuYwo+IHdoaWNoIHRh
a2VzIGEgc3VpdGFibGUgc2V0IG9mIGFyZ3VtZW50cy4KClN1cmUgYnV0IHBlcmhhcHMgdGhhdCdz
IG5vdCBmZWFzaWJsZSBhcyB0aGUgc3Vycm91bmRpbmcgb3V0cHV0CmlzIHBlci1hcmNoIHNwZWNp
ZmljLgoKV2hhdCBjb3VsZCBiZSBhIHN0YW5kYXJkaXplZCBmYXVsdCBtZXNzYWdlIGhlcmU/Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwg
bWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
