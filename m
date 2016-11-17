From: Steve Ellcey <sellcey@caviumnetworks.com>
Subject: Re: ILP32 for ARM64: testing with glibc testsuite
Date: Thu, 17 Nov 2016 13:45:36 -0800
Message-ID: <1479419136.908.90.camel@caviumnetworks.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <20161107082359.GA19666@yury-N73SV> <20161109095650.GA22804@yury-N73SV>
 <CC4F99A7-1FD2-486A-BD66-ED06F1B8BF50@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CC4F99A7-1FD2-486A-BD66-ED06F1B8BF50@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-doc@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>, catalin.marinas@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>, "Joseph S. Myers" <joseph@codesourcery.com>, linux-arch@vger.kernel.org, zhouchengming1@huawei.com, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, agraf@suse.de, Geert Uytterhoeven <geert@linux-m68k.org>, kilobyte@angband.pl, manuel.montezelo@gmail.com, arnd@arndb.de, Andrew Pinski <pinskia@gmail.com>, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, linux-arm-kernel@lists.infradead.org, GNU C Library <libc-alpha@sourceware.org>, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, Adhemerval Zanella <adhemerval.zanella@linaro.org>, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org

T24gV2VkLCAyMDE2LTExLTE2IGF0IDE1OjIyICswNDAwLCBNYXhpbSBLdXZ5cmtvdiB3cm90ZToK
PiA+IAo+ID4gT24gTm92IDksIDIwMTYsIGF0IDE6NTYgUE0sIFl1cnkgTm9yb3YgPHlub3JvdkBj
YXZpdW1uZXR3b3Jrcy5jb20+Cj4gPiB3cm90ZToKPiA+IAo+ID4gPiAKPiA+ID4gQmVsb3cgaXMg
dGhlIHJlc3VsdHMgb2YgZ2xpYmMgdGVzdHN1aXRlIHJ1biBmb3IgYWFyY2g2NC9scDY0CgpJIGhh
dmUgYmVlbiBydW5uaW5nIHRoZSBnbGliYyB0ZXN0c3VpdGUgYXMgd2VsbC4gwqBJIGhhdmUgb25s
eSBydW4gaXQgb24KYW4gSUxQMzIgZW5hYmxlZCBrZXJuZWwuIMKgVXNpbmcgdGhhdCBrZXJuZWws
IHRvcC1vZi10cmVlIGdsaWJjLCBhbmQgdGhlCklMUDMyIGdsaWJjIHBhdGNoZXMgSSBoYXZlIG5v
IExQNjQgcmVncmVzc2lvbnMuIMKgVGhlcmUgYXJlIDUgZmFpbHVyZXMKaW4gTFA2NCBtb2RlIGJ1
dCBJIGdldCB0aGVtIHdpdGggdmFuaWxsYSB0b3Atb2YtdHJlZSBnbGliYyBzb3VyY2VzIHRvby4K
VGhleSBhcmU6CglucHRsL2VpbnRyMSAoSSBhY3R1YWxseSBkb24ndCBydW4gdGhpcyBiZWNhdXNl
IGl0IGtpbGxzIHRoZSAnbWFrZSBjaGVjaycpCglkZWJ1Zy90c3QtYmFja3RyYWNlNQoJZGVidWcv
dHN0LWJhY2t0cmFjZTYKCW5wdGwvdHN0LXN0YWNrNAoJbnB0bC90c3QtdGhyZWFkX2xvY2FsMQoK
SW4gSUxQMzIgbW9kZSBJIGdldCAzMyBmYWlsdXJlcywgdGhleSBpbmNsdWRlIHRoZSBhYm92ZSBm
YWlsdXJlcyAobWludXMKbnB0bC90c3QtdGhyZWFkX2xvY2FsMSkgcGx1czoKCgljKystdHlwZXMt
Y2hlY2sKCWNvbmZvcm0vSVNPMTEvaW50dHlwZXMuaC9jb25mb3JtCgljb25mb3JtL0lTTzExL3N0
ZGludC5oL2NvbmZvcm0KCWNvbmZvcm0vSVNPOTkvaW50dHlwZXMuaC9jb25mb3JtCgljb25mb3Jt
L0lTTzk5L3N0ZGludC5oL2NvbmZvcm0KCWNvbmZvcm0vUE9TSVgyMDA4L2ludHR5cGVzLmgvY29u
Zm9ybQoJY29uZm9ybS9QT1NJWDIwMDgvc3RkaW50LmgvY29uZm9ybQoJY29uZm9ybS9YT1BFTjJL
L2ludHR5cGVzLmgvY29uZm9ybQoJY29uZm9ybS9YT1BFTjJLL3N0ZGludC5oL2NvbmZvcm0KCWNv
bmZvcm0vWE9QRU4ySzgvaW50dHlwZXMuaC9jb25mb3JtCgljb25mb3JtL1hPUEVOMks4L3N0ZGlu
dC5oL2NvbmZvcm0KCWVsZi90c3QtdGxzMQoJZWxmL3RzdC10bHMxLXN0YXRpYwoJZWxmL3RzdC10
bHMyCgllbGYvdHN0LXRsczItc3RhdGljCgllbGYvdHN0LXRsczMKCW1hdGgvY2hlY2stYWJpLWxp
Ym0KCW1hdGgvdGVzdC1kb3VibGUKCW1hdGgvdGVzdC1kb3VibGUtZmluaXRlCgltYXRoL3Rlc3Qt
ZmxvYXQKCW1hdGgvdGVzdC1mbG9hdC1maW5pdGUKCW1pc2MvdHN0LXN5bmNfZmlsZV9yYW5nZQoJ
bnB0bC90c3QtY2FuY2VsMjYKCW5wdGwvdHN0LWNhbmNlbDI3CglucHRsL3RzdC1zZW0zCglydC90
c3QtbXF1ZXVlMQoJcnQvdHN0LW1xdWV1ZTIKCXJ0L3RzdC1tcXVldWU0CglydC90c3QtbXF1ZXVl
NwoJc3RkbGliL3RzdC1tYWtlY29udGV4dDMKCkkgYW0gY3VycmVudGx5IGxvb2tpbmcgYXQgdGhl
c2UgSUxQMzIgcmVncmVzc2lvbnMgKHN0YXJ0aW5nIHdpdGggdGhlCnRscyBmYWlsdXJlcykgdG8g
c2VlIGlmIEkgY2FuIGZpZ3VyZSBvdXQgd2hhdCBpcyBoYXBwZW5pbmcgd2l0aCB0aGVtLgoKU3Rl
dmUgRWxsY2V5CnNlbGxjZXlAY2F2aXVtbmV0d29ya3MuY29tCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
