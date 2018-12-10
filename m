From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v4 3/7] mips: rename macros and files from '64'
	to 'n64'
Date: Mon, 10 Dec 2018 19:51:46 +0000
Message-ID: <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
 <1544073508-13720-4-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
In-Reply-To: <1544073508-13720-4-git-send-email-firoz.khan@linaro.org>
Content-Language: en-US
Content-ID: <6994742102DF064DB805071693ED2AB2@namprd22.prod.outlook.com>
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "y2038@lists.linaro.org" <y2038@lists.linaro.org>, James Hogan <jhogan@kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>, "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

SGkgRmlyb3osCgpPbiBUaHUsIERlYyAwNiwgMjAxOCBhdCAxMDo0ODoyNEFNICswNTMwLCBGaXJv
eiBLaGFuIHdyb3RlOgo+IGRpZmYgLS1naXQgYS9hcmNoL21pcHMvaW5jbHVkZS91YXBpL2FzbS9z
Z2lkZWZzLmggYi9hcmNoL21pcHMvaW5jbHVkZS91YXBpL2FzbS9zZ2lkZWZzLmgKPiBpbmRleCAy
NjE0M2UzLi4wMzY0ZWVjIDEwMDY0NAo+IC0tLSBhL2FyY2gvbWlwcy9pbmNsdWRlL3VhcGkvYXNt
L3NnaWRlZnMuaAo+ICsrKyBiL2FyY2gvbWlwcy9pbmNsdWRlL3VhcGkvYXNtL3NnaWRlZnMuaAo+
IEBAIC00MCw2ICs0MCw2IEBACj4gICAqLwo+ICAjZGVmaW5lIF9NSVBTX1NJTV9BQkkzMgkJMQo+
ICAjZGVmaW5lIF9NSVBTX1NJTV9OQUJJMzIJMgo+IC0jZGVmaW5lIF9NSVBTX1NJTV9BQkk2NAkJ
Mwo+ICsjZGVmaW5lIF9NSVBTX1NJTV9BQklONjQJMwoKV2hpbHN0IEkgYWdyZWUgd2l0aCBjaGFu
Z2luZyBvdXIgb3duIGRlZmluaXRpb25zICYgZmlsZW5hbWVzIHRvIHVzZSBuNjQsCnRoaXMgbWFj
cm8gYWN0dWFsbHkgcmVmbGVjdHMgbmFtaW5nIHVzZWQgYnkgdGhlIHRvb2xjaGFpbi4gaWU6Cgog
ICAgJCBtaXBzLWxpbnV4LWdjYyAtbWlwczY0IC1tYWJpPTY0IC1kTSAtRSAtIDwvZGV2L251bGwg
fCBncmVwIEFCSTY0CiAgICAjZGVmaW5lIF9BQkk2NCAzCiAgICAjZGVmaW5lIF9NSVBTX1NJTSBf
QUJJNjQKCk91ciBtYWNybyBoZXJlIGlzIHVzZWQgdG8gY29tcGFyZSBhZ2FpbnN0IF9NSVBTX1NJ
TSBwcm92aWRlZCBieSB0aGUKdG9vbGNoYWluLCBzbyBmb3IgY29uc2lzdGVuY3kgSSB0aGluayB3
ZSBzaG91bGQga2VlcCB0aGUgc2FtZSBuYW1lIGZvcgp0aGUgbWFjcm8gdGhhdCB0aGUgdG9vbGNo
YWluIHVzZXMuCgpBbmQgSSByZWFsaXNlIHRoYXQgdW5kb2luZyB0aGF0IGJ1dCBrZWVwaW5nIG42
NCBpbiBvdXIgb3duIGZpbGVuYW1lcyAmCm1hY3JvcyBpcyBhbm90aGVyIHR5cGUgb2YgaW5jb25z
aXN0ZW5jeSwgYnV0IHNvbWV0aGluZyBpbXBlcmZlY3QgaXMKdW5hdm9pZGFibGUgYXQgdGhpcyBw
b2ludCBnaXZlbiB0aGF0IHRoZSBlbmdpbmVlcnMgd2F5IGJhY2sgd2hlbiBkZWNpZGVkCnRvIHVz
ZSAiQUJJNjQiIGZvciBuNjQuCgpUaGFua3MsCiAgICBQYXVsCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClkyMDM4IG1haWxpbmcgbGlzdApZMjAzOEBsaXN0
cy5saW5hcm8ub3JnCmh0dHBzOi8vbGlzdHMubGluYXJvLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ky
MDM4Cg==
