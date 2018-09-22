From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v2 1/5] m68k: Rename system call table file name
Date: Sat, 22 Sep 2018 17:06:59 +0530
Message-ID: <CALxhOnhWMf3Zq73nMYkv4JwQUWVKiD6YepcVOFhL8AC5fggvdw@mail.gmail.com>
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org>
 <1537455973-12468-2-git-send-email-firoz.khan@linaro.org>
 <20180921054850.GA13343@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
In-Reply-To: <20180921054850.GA13343@frolo.macqel>
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: phdm@macq.eu
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

SGkgUGhpbGxpcHBlLAoKT24gRnJpLCAyMSBTZXAgMjAxOCBhdCAxMToxOCwgUGhpbGlwcGUgRGUg
TXV5dGVyIDxwaGRtQG1hY3EuZXU+IHdyb3RlOgo+Cj4gT24gVGh1LCBTZXAgMjAsIDIwMTggYXQg
MDg6MzY6MDlQTSArMDUzMCwgRmlyb3ogS2hhbiB3cm90ZToKPiA+IFRoZSBzeXN0ZW0gY2FsbCB0
YWJsZSBlbnRyaWVzIGFyZSBwcmVzZW50IGluIHN5c2NhbGx0YWJsZS5TLiBPbmUgb2YKPiA+IHRo
ZSBwYXRjaCBpbiB0aGlzIHBhdGNoIHNlcmllcyB3aWxsIGF1dG8tZ2VuZXJhdGUgdGhlIHN5c3Rl
bSBjYWxsCj4gPiB0YWJsZSBlbnRyaWVzIHVzaW5nIHRoZSBzeXN0ZW0gY2FsbCB0YWJsZSBnZW5l
cmF0aW9uIHNjcmlwdCBhbmQKPiA+IHdoaWNoJ2xsIHJlcGxhY2UgdGhlIGV4aXN0aWcgdGFibGUg
ZmlsZS4KPiA+Cj4gPiBJbiBvcmRlciB0byBjb21lIHVwIHdpdGggYSBjb21tb24gbmFtaW5nIGNv
bnZlbnRpb24gYWNyb3NzIGFsbAo+ID4gYXJjaGl0ZWN0dXJlLCB3ZSBuZWVkIHRvIGNoYW5nZSB0
aGUgZmlsZSBuYW1lIHRvIHN5c2NhbGxfdGFibGUuUy4KPgo+IFRoYXQgZmlsZSB3YXMgcHJvYmFi
bHkgY2FsbGVkIHRoYXQgd2F5IHRvIGJlIGFibGUgdG8gZGlzdGluZ3Vpc2ggaXQKPiBmcm9tIHN5
c2NhbGx0YWJsZS5zIGFuZCBzeXNjYWxsdGFibGUubyBpbiBhIGZpbGUgc3lzdGVtIHdpdGggYSAx
NAo+IGNoYXJhY3RlcnMgbGltaXQgaW4gZmlsZSBuYW1lcyAoaW4gc3lzViB1bml4IHN5c3RlbXMp
Lgo+Cj4gPiBUaGlzIGNoYW5nZSB3aWxsIHVuaWZ5IHRoZSBpbXBsZW1lbnRhdGlvbiBhY3Jvc3Mg
YWxsIGFyY2hpdGVjdHVyZS4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBGaXJveiBLaGFuIDxmaXJv
ei5raGFuQGxpbmFyby5vcmc+Cj4gPiAtLS0KPiA+ICBhcmNoL202OGsva2VybmVsL01ha2VmaWxl
ICAgICAgICB8ICAgMiArLQo+ID4gIGFyY2gvbTY4ay9rZXJuZWwvc3lzY2FsbF90YWJsZS5TIHwg
NDAzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gIGFyY2gvbTY4
ay9rZXJuZWwvc3lzY2FsbHRhYmxlLlMgIHwgNDAzIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQo+Cj4gWW91IHNob3VsZCBnZW5lcmF0ZSB5b3VyIHBhdGNoIHdpdGggdGhl
ICctTScgb3IgJy0tZmluZC1yZW5hbWVzJyBvcHRpb24uCgpTdXJlLiBUaGFua3MhCkZpcm96Cgo+
Cj4gUGhpbGlwcGUKPgo+IC0tCj4gUGhpbGlwcGUgRGUgTXV5dGVyICszMiAyIDYxMDE1MzIgTWFj
cSBTQSBydWUgZGUgbCdBZXJvbmVmIDIgQi0xMTQwIEJydXhlbGxlcwpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpZMjAzOCBtYWlsaW5nIGxpc3QKWTIwMzhA
bGlzdHMubGluYXJvLm9yZwpodHRwczovL2xpc3RzLmxpbmFyby5vcmcvbWFpbG1hbi9saXN0aW5m
by95MjAzOAo=
