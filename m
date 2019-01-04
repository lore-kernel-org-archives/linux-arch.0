From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH 1/2] xtensa: remove nargs from __SYSCALL
Date: Fri, 4 Jan 2019 11:44:13 +0530
Message-ID: <CALxhOnhVKRC0faiQTNNeUP3rYtK7aUg1Sr758ScokrBnE55iHQ@mail.gmail.com>
References: <1546442912-20818-1-git-send-email-firoz.khan@linaro.org>
 <1546442912-20818-2-git-send-email-firoz.khan@linaro.org>
 <CAMo8BfJcKGBytDQMFU7XO50uYZcwCftzsLkxLa6aDRPWJ0wW4Q@mail.gmail.com>
 <CALxhOnhy6nh3ycW5kBwqZ4o0EfoFm4MoCJ2453rDCRaX3Z-z7Q@mail.gmail.com>
 <CAMo8Bf+EJ+AaxfWGUcWMxsE=kpYD=-whAb0CxvdGYg+eK4bWpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
In-Reply-To: <CAMo8Bf+EJ+AaxfWGUcWMxsE=kpYD=-whAb0CxvdGYg+eK4bWpw@mail.gmail.com>
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Chris Zankel <chris@zankel.net>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-xtensa@linux-xtensa.org, y2038 Mailman List <y2038@lists.linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

SGkgTWF4LAoKT24gRnJpLCA0IEphbiAyMDE5IGF0IDExOjI1LCBNYXggRmlsaXBwb3YgPGpjbXZi
a2JjQGdtYWlsLmNvbT4gd3JvdGU6Cj4gT24gVGh1LCBKYW4gMywgMjAxOSBhdCA5OjE3IFBNIEZp
cm96IEtoYW4gPGZpcm96LmtoYW5AbGluYXJvLm9yZz4gd3JvdGU6Cj4gPiBPbiBGcmksIDQgSmFu
IDIwMTkgYXQgMDg6MjgsIE1heCBGaWxpcHBvdiA8amNtdmJrYmNAZ21haWwuY29tPiB3cm90ZToK
PiA+ID4gT24gV2VkLCBKYW4gMiwgMjAxOSBhdCA3OjI5IEFNIEZpcm96IEtoYW4gPGZpcm96Lmto
YW5AbGluYXJvLm9yZz4gd3JvdGU6Cj4gPiBUaGlzIHdhcyBpbnRlbnRpb25hbCBhcyBJIHdhcyB0
cnlpbmcgY29tcGlsZSBvdGhlciBvbmUgYXJjaGl0ZWN0dXJlIHdpdGggdGhlCj4gPiBwcmV2aW91
cyBpbXBsZW1lbnRhdGlvbiwgaXQgd2FzIGdpdmluZyB0aGUgZXJyb3IuIFNvIEkgbW9kaWZpZWQg
d2l0aG91dCBzcGFjZQo+ID4gYWZ0ZXIgY29tbWEuCj4KPiBJIGhhdmUgdGVzdGVkIHRoYXQgcHJl
c2VuY2Ugb3IgYWJzZW5jZSBvZiBzcGFjZSBkb2VzIG5vdCBhZmZlY3QgdGhlIGJ1aWxkCj4gZm9y
IHh0ZW5zYSwgYW5kIG5vcm1hbGx5IHdlIHB1dCBzcGFjZSBhZnRlciBhIGNvbW1hLCBzbyBJJ3Zl
IG1lbnRpb25lZCB0aGF0Lgo+Cj4gU2luY2UgdGhpcyBzY3JpcHQgaXMgYW55d2F5IHJlbW92ZWQg
aW4gdGhlIG5leHQgcGF0Y2ggb2YgdGhlIHNlcmllcyBpdCBkb2Vzbid0Cj4gcmVhbGx5IG1hdHRl
ciB3aGV0aGVyIHRoZSBzcGFjZXMgYXJlIHByZXNlbnQgb3Igbm90LgoKWWVzLCB5b3UgYXJlIHJp
Z2h0LCB0aGVyZSBpcyBubyBlZmZlY3QgaW4geHRlbnNhIGJ1dCBpZiBJJ20gcmlnaHQKdGhlcmUg
aXMgYSBwcm9ibGVtCmluIHBvd2VycGMgYXJjaGl0ZWN0dXJlIChub3QgcmVtZW1iZXJpbmcgZXhh
Y3RseSB3aGljaCBhcmNoKSB3aXRoIHRoaXMgc3BhY2UKYWZ0ZXIgY29tbWEuCgpCVFcsIHRoZSBz
Y3JpcHQgZnJvbSBhbGwgYXJjaGl0ZWN0dXJlIHdpbGwgYmUgcmVtb3ZlZCBhbmQga2VlcCBpdCBp
bgpzY3JpcHRzIGRpcmVjdG9yeQppcyBvdXIgcGxhbi4gU28gdG8gc2F0aXNmeSBwb3dlcnBjIChh
Z2FpbiBJJ20gbm90IHN1cmUgd2hpY2ggYXJjaCkgSQpqdXN0IGRpZCB0aGlzCmNoYW5nZS4KClRo
YW5rcyBmb3IgeW91ciBmZWVkYmFjay4KCkZpcm96Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClkyMDM4IG1haWxpbmcgbGlzdApZMjAzOEBsaXN0cy5saW5h
cm8ub3JnCmh0dHBzOi8vbGlzdHMubGluYXJvLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3kyMDM4Cg==
