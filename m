From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH 2/2] sh: generate uapi header and syscall table
 header files
Date: Fri, 11 Jan 2019 22:21:30 -0600
Message-ID: <d329d7b8-62fb-9cb0-521e-ee7887f122a1@landley.net>
References: <1546443445-21075-1-git-send-email-firoz.khan@linaro.org>
 <1546443445-21075-3-git-send-email-firoz.khan@linaro.org>
 <20190110235428.GA10016@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
In-Reply-To: <20190110235428.GA10016@roeck-us.net>
Content-Language: en-US
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: Guenter Roeck <linux@roeck-us.net>, Firoz Khan <firoz.khan@linaro.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-arch@vger.kernel.org, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org, y2038@lists.linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, marcin.juszkiewicz@linaro.org, arnd@arndb.de, deepa.kernel@gmail.com, Philippe Ombredanne <pombredanne@nexb.com>, Simon Horman <horms+renesas@verge.net.au>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

T24gMS8xMC8xOSA1OjU0IFBNLCBHdWVudGVyIFJvZWNrIHdyb3RlOgo+IE9uIFdlZCwgSmFuIDAy
LCAyMDE5IGF0IDA5OjA3OjI1UE0gKzA1MzAsIEZpcm96IEtoYW4gd3JvdGU6Cj4+IFVuaWZpZWQg
c3lzdGVtIGNhbGwgdGFibGUgZ2VuZXJhdGlvbiBzY3JpcHQgbXVzdCBiZSBydW4gdG8KPj4gZ2Vu
ZXJhdGUgdW5pc3RkXzMyLmggYW5kIHN5c2NhbGxfdGFibGUuaCBmaWxlcy4gVGhpcyBwYXRjaAo+
PiB3aWxsIGhhdmUgY2hhbmdlcyB3aGljaCB3aWxsIGludm9rZXMgdGhlIHNjcmlwdC4KPj4KPj4g
VGhpcyBwYXRjaCB3aWxsIGdlbmVyYXRlIHVuaXN0ZF8zMi5oIGFuZCBzeXNjYWxsX3RhYmxlLmgK
Pj4gZmlsZXMgYnkgdGhlIHN5c2NhbGwgdGFibGUgZ2VuZXJhdGlvbiBzY3JpcHQgaW52b2tlZCBi
eQo+PiBzaC9NYWtlZmlsZSBhbmQgdGhlIGdlbmVyYXRlZCBmaWxlcyBhZ2FpbnN0IHRoZSByZW1v
dmVkCj4+IGZpbGVzIG11c3QgYmUgaWRlbnRpY2FsLgo+Pgo+PiBUaGUgZ2VuZXJhdGVkIHVhcGkg
aGVhZGVyIGZpbGUgd2lsbCBiZSBpbmNsdWRlZCBpbiB1YXBpLy0KPj4gYXNtL3VuaXN0ZC5oIGFu
ZCBnZW5lcmF0ZWQgc3lzdGVtIGNhbGwgdGFibGUgaGVhZGVyIGZpbGUKPj4gd2lsbCBiZSBpbmNs
dWRlZCBieSBrZXJuZWwvc3lzY2FsbF8zMi5TIGZpbGUuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEZp
cm96IEtoYW4gPGZpcm96LmtoYW5AbGluYXJvLm9yZz4KPiAKPiBIYXZlIHlvdSB0ZXN0ZWQgdGhp
cyBwYXRjaCA/CgpJIHRlc3RlZCBpdCBhdCBvbmUgcG9pbnQsIGJ1dCBub3QgcmVjZW50bHkuIChJ
dCB3YXMgYmVmb3JlIDQuMjAgY2FtZSBvdXQuLi4pCgpSb2IKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KWTIwMzggbWFpbGluZyBsaXN0ClkyMDM4QGxpc3Rz
LmxpbmFyby5vcmcKaHR0cHM6Ly9saXN0cy5saW5hcm8ub3JnL21haWxtYW4vbGlzdGluZm8veTIw
MzgK
