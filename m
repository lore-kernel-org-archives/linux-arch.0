From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
Date: Wed, 15 Jun 2011 13:24:24 +0200
Message-ID: <BANLkTimMLDb6LL0HZv8XtHt=zvyE7eybyg@mail.gmail.com>
References: <20110614190850.GA13526@linux-mips.org>
	<201106142333.16203.arnd@arndb.de> <4DF83577.6040903@zytor.com>
	<201106151146.13320.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201106151146.13320.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Lennox Wu <lennox.wu@gmail.com>, linux-arch@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>, Russell King <linux@arm.linux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, microblaze-uclinux@itee.uq.edu.au, Chris Metcalf <cmetcalf@tilera.com>, Mikael Starvik <starvik@axis.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infrade
List-Id: linux-arch.vger.kernel.org

T24gV2VkLCBKdW4gMTUsIDIwMTEgYXQgMTE6NDYsIEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIu
ZGU+IHdyb3RlOgo+ICogSW4gY2FzZSBvZiBmbG9wcGllcywgdGhlICJzb2x1dGlvbiIgd2FzIHRv
IHdyaXRlIGEgZHJpdmVyIGZvciBldmVyeSBwbGF0Zm9ybSB0aGF0Cj4gwqBkb2Vzbid0IGhhdmUg
UElPLCBzaW5jZSB0aGV5IHRlbmQgdG8gaGF2ZSBvdGhlciBkaWZmZXJlbmNlcy4gVGhlIGFtaWZs
b3AgYW5kCj4gwqBhdGFmbG9wIGRyaXZlcnMgYXJlIG5vdCBldmVuIHVzZSByZWFkYigpLCB0aGV5
IGp1c3QgZGVyZWZlbmNlIHZvbGF0aWxlIHBvaW50ZXJzCj4gwqB0byBkbyBNTUlPLiBJIGRvdWJ0
IHdlIGNhbiBmaW5kIHZvbHVudGVlcnMgdG8gY2xlYW4gdGhhdCB1cC4KCkFtaWZsb3AgZHJpdmVz
IHRoZSBBbWlnYSBmbG9wcHkgY29udHJvbGxlciwgd2hpY2ggaXMgY29tcGxldGVseQpkaWZmZXJl
bnQgZnJvbSB0aGUKUEMtc3R5bGUgZmxvcHB5IGNvbnRyb2xsZXIuCkF0YWZsb3AgZHJpdmVzIHRo
ZSBBdGFyaSBmbG9wcHkgY29udHJvbGxlciwgd2hpY2ggc2VlbXMgdG8gYmUgYSBXRDE3NzIgYW5k
IG5vdApyZWxhdGVkIHRvIFBDLXN0eWxlIGZsb3BweSBjb250cm9sbGVycyBuZWl0aGVyLgoKU28g
bm9uZSBvZiB0aGVtIGRyaXZlIFBDLXN0eWxlIGhhcmR3YXJlLCBhbmQgYm90aCBwcmVkYXRlIHRo
ZSBnZW5lcmljIHJlYWRiKCkKaW5mcmFzdHJ1Y3R1cmUuCgpHcntvZXRqZSxlZXRpbmd9cywKCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEdlZXJ0CgotLQpHZWVydCBVeXR0ZXJo
b2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4
LW02OGsub3JnCgpJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3Bs
ZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5h
bGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoMKgIC0tIExpbnVzIFRv
cnZhbGRzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
