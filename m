From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v6,
	1/5] powerpc: add __NR_syscalls along with NR_syscalls
Date: Mon, 24 Dec 2018 00:28:03 +1100 (AEDT)
Message-ID: <43N38M4cw7z9sNJ@ozlabs.org>
References: <1545043236-11649-2-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
In-Reply-To: <1545043236-11649-2-git-send-email-firoz.khan@linaro.org>
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: linuxppc-dev@lists.ozlabs.org, sathnaga@linux.vnet.ibm.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Ram Pai <linuxram@us.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Boqun Feng <boqun.feng@gmail.com>, Breno Leitao <leitao@debian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: linux-arch@vger.kernel.org, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org, deepa.kernel@gmail.com
List-Id: linux-arch.vger.kernel.org

T24gTW9uLCAyMDE4LTEyLTE3IGF0IDEwOjQwOjMyIFVUQywgRmlyb3ogS2hhbiB3cm90ZToKPiBO
Ul9zeXNjYWxscyBtYWNybyBob2xkcyB0aGUgbnVtYmVyIG9mIHN5c3RlbSBjYWxsIGV4aXN0Cj4g
aW4gcG93ZXJwYyBhcmNoaXRlY3R1cmUuIFdlIGhhdmUgdG8gY2hhbmdlIHRoZSB2YWx1ZSBvZgo+
IE5SX3N5c2NhbGxzLCBpZiB3ZSBhZGQgb3IgZGVsZXRlIGEgc3lzdGVtIGNhbGwuCj4gCj4gT25l
IG9mIHRoZSBwYXRjaCBpbiB0aGlzIHBhdGNoIHNlcmllcyBoYXMgYSBzY3JpcHQgd2hpY2gKPiB3
aWxsIGdlbmVyYXRlIGEgdWFwaSBoZWFkZXIgYmFzZWQgb24gc3lzY2FsbC50YmwgZmlsZS4KPiBU
aGUgc3lzY2FsbC50YmwgZmlsZSBjb250YWlucyB0aGUgbnVtYmVyIG9mIHN5c3RlbSBjYWxsCj4g
aW5mb3JtYXRpb24uIFNvIHdlIGhhdmUgdHdvIG9wdGlvbiB0byB1cGRhdGUgTlJfc3lzY2FsbHMK
PiB2YWx1ZS4KPiAKPiAxLiBVcGRhdGUgTlJfc3lzY2FsbHMgaW4gYXNtL3VuaXN0ZC5oIG1hbnVh
bGx5IGJ5IGNvdW50LQo+ICAgIGluZyB0aGUgbm8ub2Ygc3lzdGVtIGNhbGxzLiBObyBuZWVkIHRv
IHVwZGF0ZSBOUl9zeXMtCj4gICAgY2FsbHMgdW50aWwgd2UgZWl0aGVyIGFkZCBhIG5ldyBzeXN0
ZW0gY2FsbCBvciBkZWxldGUKPiAgICBleGlzdGluZyBzeXN0ZW0gY2FsbC4KPiAKPiAyLiBXZSBj
YW4ga2VlcCB0aGlzIGZlYXR1cmUgaW4gYWJvdmUgbWVudGlvbmVkIHNjcmlwdCwKPiAgICB0aGF0
IHdpbGwgY291bnQgdGhlIG51bWJlciBvZiBzeXNjYWxscyBhbmQga2VlcCBpdCBpbgo+ICAgIGEg
Z2VuZXJhdGVkIGZpbGUuIEluIHRoaXMgY2FzZSB3ZSBkb24ndCBuZWVkIHRvIGV4cGxpLQo+ICAg
IGNpdGx5IHVwZGF0ZSBOUl9zeXNjYWxscyBpbiBhc20vdW5pc3RkLmggZmlsZS4KPiAKPiBUaGUg
Mm5kIG9wdGlvbiB3aWxsIGJlIHRoZSByZWNvbW1lbmRlZCBvbmUuIEZvciB0aGF0LCBJCj4gYWRk
ZWQgdGhlIF9fTlJfc3lzY2FsbHMgbWFjcm8gaW4gdWFwaS9hc20vdW5pc3RkLmggYWxvbmcKPiB3
aXRoIE5SX3N5c2NhbGxzIGFzbS91bmlzdGQuaC4gVGhlIG1hY3JvIF9fTlJfc3lzY2FsbHMKPiBh
bHNvIGFkZGVkIGZvciBtYWtpbmcgdGhlIG5hbWUgY29udmVudGlvbiBzYW1lIGFjcm9zcyBhbGwK
PiBhcmNoaXRlY3R1cmUuIFdoaWxlIF9fTlJfc3lzY2FsbHMgaXNuJ3Qgc3RyaWN0bHkgcGFydCBv
Zgo+IHRoZSB1YXBpLCBoYXZpbmcgaXQgYXMgcGFydCBvZiB0aGUgZ2VuZXJhdGVkIGhlYWRlciB0
bwo+IHNpbXBsaWZpZXMgdGhlIGltcGxlbWVudGF0aW9uLiBXZSBhbHNvIG5lZWQgdG8gZW5jbG9z
ZQo+IHRoaXMgbWFjcm8gd2l0aCAjaWZkZWYgX19LRVJORUxfXyB0byBhdm9pZCBzaWRlIGVmZmVj
dHMuCj4gCj4gU2lnbmVkLW9mZi1ieTogRmlyb3ogS2hhbiA8Zmlyb3oua2hhbkBsaW5hcm8ub3Jn
PgoKU2VyaWVzIGFwcGxpZWQgdG8gcG93ZXJwYyBuZXh0LCB0aGFua3MuCgpodHRwczovL2dpdC5r
ZXJuZWwub3JnL3Bvd2VycGMvYy84YTE5ZWVlYWI2NmRmZGQ3YzY3YmM4ZTMwNDhhYzAKCmNoZWVy
cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpZMjAzOCBt
YWlsaW5nIGxpc3QKWTIwMzhAbGlzdHMubGluYXJvLm9yZwpodHRwczovL2xpc3RzLmxpbmFyby5v
cmcvbWFpbG1hbi9saXN0aW5mby95MjAzOAo=
