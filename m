From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
Date: Tue, 14 Jun 2011 22:32:08 +0200
Message-ID: <BANLkTikuVsFS-UbS+Dap2Zy-f1+qLc1TLw@mail.gmail.com>
References: <20110614190850.GA13526@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110614190850.GA13526@linux-mips.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Lennox Wu <lennox.wu@gmail.com>, linux-arch@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>, Russell King <linux@arm.linux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, microblaze-uclinux@itee.uq.edu.au, Chris Metcalf <cmetcalf@tilera.com>, Mikael Starvik <starvik@axis.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Thomas
List-Id: linux-arch.vger.kernel.org

T24gVHVlLCBKdW4gMTQsIDIwMTEgYXQgMjE6MDgsIFJhbGYgQmFlY2hsZSA8cmFsZkBsaW51eC1t
aXBzLm9yZz4gd3JvdGU6Cj4gVGhlIFBDIHBhcmFsbGVsIHBvcnQgS2NvbmZpZyBhcyBhY3F1aXJl
ZCBvbmUgb2YgdGhvc2UgbWVzc3kgdGVybXMgdG8KPiBkZXNjcmliZSBpdCdzIGFyY2hpdGVjdHVy
ZSBkZXBlbmRlbmNpZXM6Cj4KPiDCoCDCoCDCoCBkZXBlbmRzIG9uICghU1BBUkM2NCB8fCBQQ0kp
ICYmICFTUEFSQzMyICYmICFNMzJSICYmICFGUlYgJiYgXAo+IMKgIMKgIMKgIMKgIMKgIMKgIMKg
ICghTTY4SyB8fCBJU0EpICYmICFNTjEwMzAwICYmICFBVlIzMiAmJiAhQkxBQ0tGSU4KPgo+IFRo
aXMgaXNuJ3QganVzdCB1Z2x5IC0gaXQgYWxzbyBhbG1vc3QgY2VydGFpbmx5IGRlc2NyaWJlcyB0
aGUgZGVwZW5kZW5jaWVzCj4gdG9vIGNvYXJzZSBncmFpbmVkbHkuIMKgVGhpcyBpcyBhbiBhdHRl
bXB0IGF0IGNsZWFpbmcgdGhlIG1lc3MgdXAuCgo+IC0tLSBhL2FyY2gvbTY4ay9LY29uZmlnLm1t
dQo+ICsrKyBiL2FyY2gvbTY4ay9LY29uZmlnLm1tdQo+IEBAIC0zOTksNiArMzk5LDcgQEAgY29u
ZmlnIElTQQo+IMKgIMKgIMKgIMKgYm9vbAo+IMKgIMKgIMKgIMKgZGVwZW5kcyBvbiBRNDAgfHwg
QU1JR0FfUENNQ0lBCj4gwqAgwqAgwqAgwqBkZWZhdWx0IHkKPiArIMKgIMKgIMKgIHNlbGVjdCBQ
QVJQT1JUX1BDCgpXaHkgZG8geW91IHNlbGVjdCBQQVJQT1JUX1BDIGhlcmUgaW5zdGVhZCBvZiBI
QVZFX1BDX1BBUlBPUlQ/CgpHcntvZXRqZSxlZXRpbmd9cywKCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIEdlZXJ0CgotLQpHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBs
b3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnCgpJbiBwZXJz
b25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBh
IGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAi
cHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoMKgIC0tIExpbnVzIFRvcnZhbGRzCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
