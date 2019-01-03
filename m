From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH 2/2] m68k: generate uapi header and syscall
	table header files
Date: Thu, 3 Jan 2019 17:30:46 +0530
Message-ID: <CALxhOnhhHy2ztRiCn4400UweHU_+O_t2Wf5862Rc_Dyh3NtNPQ@mail.gmail.com>
References: <1546442319-20461-1-git-send-email-firoz.khan@linaro.org>
 <1546442319-20461-3-git-send-email-firoz.khan@linaro.org>
 <CAMuHMdUT3B2JLkijM5Ofd3TUYa8TZJaj1NWaEJvU_19B-naF-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
In-Reply-To: <CAMuHMdUT3B2JLkijM5Ofd3TUYa8TZJaj1NWaEJvU_19B-naF-w@mail.gmail.com>
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

SGkgR2VlcnQsCgpUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2shCgpPbiBUaHUsIDMgSmFuIDIwMTkg
YXQgMTc6MTMsIEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+IHdyb3Rl
Ogo+ID4gVGhlIGdlbmVyYXRlZCB1YXBpIGhlYWRlciBmaWxlIHdpbGwgYmUgaW5jbHVkZWQgaW4g
dWFwaS8tCj4gPiBhc20vdW5pc3RkLmggYW5kIGdlbmVyYXRlZCBzeXN0ZW0gY2FsbCB0YWJsZSBo
ZWFkZXIgZmlsZQo+ID4gd2lsbCBiZSBpbmNsdWRlZCBieSBrZXJuZWwvc3lzY2FsbHRhYmxlLlMg
ZmlsZS4KPgo+IFRoaXMgZG9lc24ndCByZWFsbHkgZGVzY3JpYmUgd2hhdCB0aGlzIHBhdGNoIGlz
IGRvaW5nLgo+IFRoaXMgcGF0Y2ggc3dpdGNoZXMgbTY4ayBvdmVyIHRvIHVzZSB0aGUgY29tbW9u
IHNjcmlwdHMgZm9yCj4gc3lzdGVtIGNhbGwgaGVhZGVyIGZpbGUgZ2VuZXJhdGlvbi4KClN1cmUu
IEknbGwgY29tcG9zZSBuZXcgY29tbWl0IG1lc3NhZ2UuCgo+ID4gIHN5c2NhbGwgOj0gJChzcmN0
cmVlKS8kKHNyYykvc3lzY2FsbC50YmwKPiA+IC1zeXNoZHIgOj0gJChzcmN0cmVlKS8kKHNyYykv
c3lzY2FsbGhkci5zaAo+ID4gLXN5c3RibCA6PSAkKHNyY3RyZWUpLyQoc3JjKS9zeXNjYWxsdGJs
LnNoCj4gPiArc3lzaGRyIDo9ICQoc3JjdHJlZSkvc2NyaXB0cy9zeXNjYWxsaGRyLnNoCj4gPiAr
c3lzbnIgOj0gJChzcmN0cmVlKS9zY3JpcHRzL3N5c2NhbGxuci5zaAo+Cj4gV2hhdCdzIHRoZSBw
dXJwb3NlIG9mIGFkZGluZyBzeXNucj8KClllcy4gVGhpcyBpcyBub3QgcmVhbGx5IHJlcXVpcmVk
IGhlcmUuIEkgcGxhbm5lZCB0byBjaGFuZ2UgdGhlCmltcGxlbWVudGF0aW9uIGluIHNvbWUgb3Ro
ZXIgd2F5LCBidXQgZGlkbid0IGxvb2tzIHBlcmZlY3QgYW5kCnRoaXMgd2FzIGxlZnQgaGVyZSB1
bm5vdGljZWQuCgo+ID4KPiA+ICtxdWlldF9jbWRfc3lzbnIgPSBTWVNOUiAgJEAKPiA+ICsgICAg
ICBjbWRfc3lzbnIgPSAkKENPTkZJR19TSEVMTCkgJyQoc3lzbnIpJyAnJDwnICckQCcgICAgICAg
ICBcCj4gPiArICAgICAgICAgICAgICAgICAnJChzeXNucl9hYmlzXyQoYmFzZXRhcmdldCkpJyAg
ICAgICAgICAgICAgICAgXAo+ID4gKyAgICAgICAgICAgICAgICAgJyQoc3lzbnJfcGZ4XyQoYmFz
ZXRhcmdldCkpJyAgICAgICAgICAgICAgICAgIFwKPiA+ICsgICAgICAgICAgICAgICAgICckKHN5
c25yX29mZnNldF8kKGJhc2V0YXJnZXQpKScKPiA+ICsKPgo+IFdoYXQncyB0aGUgcHVycG9zZSBv
ZiBhZGRpbmcgdGhpcyBidWlsZCBydWxlLCB3aGljaCBpcyB1bnVzZWQ/CgpTdXJlLgoKRmlyb3oK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KWTIwMzggbWFp
bGluZyBsaXN0ClkyMDM4QGxpc3RzLmxpbmFyby5vcmcKaHR0cHM6Ly9saXN0cy5saW5hcm8ub3Jn
L21haWxtYW4vbGlzdGluZm8veTIwMzgK
