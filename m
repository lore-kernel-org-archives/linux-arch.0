From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/6] timex: prepare compat helpers for y2038
	changes
Date: Thu, 5 Jul 2018 22:33:55 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1807052232310.1771@nanos.tec.linutronix.de>
References: <20180703054422.12089-4-deepa.kernel@gmail.com>
 <201807051322.sUohKhUO%fengguang.wu@intel.com>
 <CABeXuvoXX2=0XrnpDjxu74QBK3zd6qEk46tzYrMuRD+-FKjbZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
In-Reply-To: <CABeXuvoXX2=0XrnpDjxu74QBK3zd6qEk46tzYrMuRD+-FKjbZw@mail.gmail.com>
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, kbuild test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>, palmer@sifive.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild-all@01.org, linux-riscv@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

T24gVGh1LCA1IEp1bCAyMDE4LCBEZWVwYSBEaW5hbWFuaSB3cm90ZToKCj4gVGhlIGVycm9yIGlz
IGZpeGVkIHdpdGggdGhlIGZvbGxvd2luZyBwYXRjaCB0aGF0IGdvZXMgaW4gYmVmb3JlIHBhdGNo
Cj4gMy82IGFib3ZlIGluIHRoZSBzZXJpZXMuCj4gTGV0IG1lIGtub3cgaWYgSSBzaG91bGQgcG9z
dCBhIHYyIGluc3RlYWQuCj4gCj4gVGhhbmtzLAo+IERlZXBhCj4gCj4gCj4gY29tbWl0IGJmZTRi
MDQ2ZWQ3ZjAxMTU0YWVmNDRmY2I3N2QzZjE3MjkyOWNjYzIKPiBBdXRob3I6IERlZXBhIERpbmFt
YW5pIDxkZWVwYS5rZXJuZWxAZ21haWwuY29tPgo+IERhdGU6ICAgVGh1IEp1bCA1IDExOjQ3OjI1
IDIwMTggLTA3MDAKPiAKPiAgICAgcmlzY3Y6IEluY2x1ZGUgYXNtLWdlbmVyaWMvY29tcGF0LmgK
PiAKPiAgICAgcmlzY3YgZG9lcyBub3QgZW5hYmxlIENPTkZJR19DT01QQVQgaW4gZGVmYXVsdCBj
b25maWd1cmF0aW9uczoKPiAgICAgZGVmY29uZmlnLCBhbGxtb2Rjb25maWcgYW5kIG5vbW9kY29u
ZmlnLgo+ICAgICBBbmQgaGVuY2UgZG9lcyBub3QgaW5sdWRlIGRlZmluaXRpb25zIGZvciBjb21w
YXQgZGF0YSB0eXBlcy4KPiAKPiAgICAgTm93IHRoYXQgdGltZSBzeXNjYWxscyBhcmUgYmVpbmcg
cmV1c2VkIGluIG5vbiBDT05GSUdfQ09NUEFUCj4gICAgIG1vZGVzLCBpbmNsdWRlIGFzbS1nZW5l
cmljIGRlZmluaXRpb25zIGZvciByaXNjdi4KPiAKPiAgICAgQWx0ZXJuYXRpdmUgd291bGQgYmUg
dG8gbWFrZSBjb21wYXRfdGltZS5oIHRvIGJlIGNvbmRpdGlvbmFsIG9uCj4gICAgIENPTkZJR19D
T01QQVRfMzJCSVRfVElNRS4gQnV0LCBzaW5jZSByaXNjdiBpcyBhbHJlYWR5IGhhcyBhbgo+ICAg
ICBhc20vY29tcGF0LmggaW5jbHVkZSB0aGUgZ2VuZXJpYyB2ZXJzaW9uIGluc3RlYWQuCj4gCj4g
ICAgIFNpZ25lZC1vZmYtYnk6IERlZXBhIERpbmFtYW5pIDxkZWVwYS5rZXJuZWxAZ21haWwuY29t
Pgo+ICAgICBDYzogcGFsbWVyQHNpZml2ZS5jb20KPiAgICAgQ2M6IGxpbnV4LXJpc2N2QGxpc3Rz
LmluZnJhZGVhZC5vcmcKClBvc3QgYSByZWFsIHBhdGNoIHBsZWFzZSBpbnN0ZWFkIG9mIHNvbWV0
aGluZyB3aGljaCBJIGhhdmUgdG8gY2xlYW51cAptYW51YWxseS4gQSBWMiBvZiB0aGUgc2VyaWVz
IGlzIHByb2JhYmx5IHRoZSBzaW1wbGVzdCB3YXkuCgpUaGFua3MsCgoJdGdseApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpZMjAzOCBtYWlsaW5nIGxpc3QK
WTIwMzhAbGlzdHMubGluYXJvLm9yZwpodHRwczovL2xpc3RzLmxpbmFyby5vcmcvbWFpbG1hbi9s
aXN0aW5mby95MjAzOAo=
