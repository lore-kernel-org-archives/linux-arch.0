From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v4 5/6] parisc: wire up rseq system call
Date: Fri, 12 Oct 2018 15:46:29 +0530
Message-ID: <CALxhOnhj7qUj57tLX12KmbcE5G-zDK2Qf2fTUbQ=jpmiUcr52w@mail.gmail.com>
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
 <1539337442-3676-6-git-send-email-firoz.khan@linaro.org>
 <CAK8P3a1gsuM7mBGm9hx-BTs=HAG3cSjB6M7N-kpMmPy3kixeCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
In-Reply-To: <CAK8P3a1gsuM7mBGm9hx-BTs=HAG3cSjB6M7N-kpMmPy3kixeCQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-parisc@vger.kernel.org, y2038 Mailman List <y2038@lists.linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Helge Deller <deller@gmx.de>, "James E . J . Bottomley" <jejb@parisc-linux.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

SGkgQXJuZCwKCk9uIEZyaSwgMTIgT2N0IDIwMTggYXQgMTU6MjYsIEFybmQgQmVyZ21hbm4gPGFy
bmRAYXJuZGIuZGU+IHdyb3RlOgo+Cj4gT24gRnJpLCBPY3QgMTIsIDIwMTggYXQgMTE6NDUgQU0g
Rmlyb3ogS2hhbiA8Zmlyb3oua2hhbkBsaW5hcm8ub3JnPiB3cm90ZToKPiA+Cj4gPiBXaXJlIHVw
IHJzZXEgc3lzdGVtIGNhbGwgcmVxdWlyZXMgYW4gYXJjaGl0ZWN0dXJlIHNwZWNpZmljCj4gPiBp
bXBsZW1lbnRhdGlvbiBhcyBpdCBub3QgcHJlc2VudCBub3cuCj4gPgo+ID4gU2lnbmVkLW9mZi1i
eTogRmlyb3ogS2hhbiA8Zmlyb3oua2hhbkBsaW5hcm8ub3JnPgo+Cj4gRGlkbid0IHdlIGNvbmNs
dWRlIHRoYXQgdGhpcyBzaG91bGQgYmUgc2tpcHBlZD8KCkhlbGdlIHRvbGQgIkkgcHJlZmVyIHRv
IGtlZXAgdGhlIHdhcm5pbmcgZm9yIHJzZXEgZm9yIG5vdy4KSXQgcmVtaW5kcyBtZSB0aGF0IHdl
IHN0aWxsIG1heSB3YW50IHRoZSByc2VxIHN5c2NhbGwuCklmIHRoZSB3YXJuaW5nIGlzIGEgcHJv
YmxlbSwgeW91IG1heSBzaW1wbHkgYWRkIHRoZSBfX0lHTk9SRV9yc2VxIGRlZmluZS4iCgpJIGNo
b3NlIHRoaXMgb3B0aW9uOyBJIGZlZWwgaXQgbG9va3MgY2xlYW4KIiMgcnNlcSByZXF1aXJlcyBh
biBhcmNoaXRlY3R1cmUgc3BlY2lmaWMgaW1wbGVtZW50YXRpb24iIGluIHN5c2NhbGwudGJsCmhv
cGVmdWxseSByZW1pbmQgaGltIHRvIGFkZCByc2VxIHN5c2NhbGwgaW1wbGVtZW50YXRpb24gaW4g
dGhpcyBhcmNoaXRlY3R1cmUuCgpGaXJvegoKPgo+ICAgICAgICBBcm5kCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClkyMDM4IG1haWxpbmcgbGlzdApZMjAz
OEBsaXN0cy5saW5hcm8ub3JnCmh0dHBzOi8vbGlzdHMubGluYXJvLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3kyMDM4Cg==
