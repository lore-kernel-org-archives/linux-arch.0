From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v13 00/12] Support for creating generic PCI host bridges
 from DT
Date: Wed, 8 Oct 2014 12:46:07 +0100
Message-ID: <20141008114606.GG4652@e106497-lin.cambridge.arm.com>
References: <1412000971-9242-1-git-send-email-Liviu.Dudau@arm.com>
 <20140929194335.GA13747@google.com>
 <20140930103942.GO841@e106497-lin.cambridge.arm.com>
 <20140930161805.GB5625@google.com>
 <20140930165431.GV841@e106497-lin.cambridge.arm.com>
 <20141008074428.GD20256@rric.localhost>
 <20141008091321.GC4652@e106497-lin.cambridge.arm.com>
 <20141008103600.GS20170@rric.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20141008103600.GS20170@rric.localhost>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robert Richter <rric@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-pci <linux-pci@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Grant Likely <grant.likely@secretlab.ca>, Tanmay Inamdar <tinamdar@apm.com>, linux-arch <linux-arch@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, Jingoo Han <jg1.han@samsung.com>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Device Tree ML <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>, Sinan Kaya <okaya@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, Jiang Liu <jiang.liu@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

T24gV2VkLCBPY3QgMDgsIDIwMTQgYXQgMTE6MzY6MDBBTSArMDEwMCwgUm9iZXJ0IFJpY2h0ZXIg
d3JvdGU6Cj4gT24gMDguMTAuMTQgMTA6MTM6MjEsIExpdml1IER1ZGF1IHdyb3RlOgo+ID4gT24g
V2VkLCBPY3QgMDgsIDIwMTQgYXQgMDg6NDQ6MjhBTSArMDEwMCwgUm9iZXJ0IFJpY2h0ZXIgd3Jv
dGU6Cj4gPiA+IEkgYXNzdW1lIHBjaS9ob3N0LWdlbmVyaWMgaXMgdGhlIGxhdGVzdCBub3cgd2l0
aCB0aGlzIGlzc3VlIGZpeGVkIGFzCj4gPiA+IHRoZSBjb21taXQgZGF0ZSBpcyAyMDE0LTEwLTAx
IHBhc3QgeW91IG1lc3NhZ2UgYWJvdmUsIHJpZ2h0PyBTbyBpcyBpdAo+ID4gPiBvayB0byByZWJh
c2Ugb3VyIGhvc3QgY29udHJvbGxlciBkcml2ZXIgb250byBwY2kvaG9zdC1nZW5lcmljIG9yIHdp
bGwKPiA+ID4gdGhlcmUgYmUgZnVydGhlciB1cGRhdGVzIG9yIGFueSBvdGhlciBicmFuY2ggdGhh
dCBpcyBuZXdlcj8KPiA+IAo+ID4gWW91IGNhbiByZWJhc2UgZWl0aGVyIG9uIHRvcCBvZiBCam9y
bidzIG5leHQgYnJhbmNoIG9yIHVzZSBsaW51eC1uZXh0LiBIb3BlIHRvCj4gPiBzZWUgaXQgaW4g
djMuMTggc29vbi4KPiAKPiBUaGFua3MgTGl2aXUuIFNvIEkgd2lsbCB1c2UgcGNpL2hvc3QtZ2Vu
ZXJpYyB3aGljaCBpcyB3aGF0IGlzIGluCj4gcGNpL25leHQ6Cj4gCj4gIGQxZTZkYzkxYjUzMiBh
cm02NDogQWRkIGFyY2hpdGVjdHVyYWwgc3VwcG9ydCBmb3IgUENJCgpZZXMsIHRoYXQncyB0aGUg
b25lLgoKQmVzdCByZWdhcmRzLApMaXZpdQoKPiAKPiAtUm9iZXJ0Cj4gCgotLSAKPT09PT09PT09
PT09PT09PT09PT0KfCBJIHdvdWxkIGxpa2UgdG8gfAp8IGZpeCB0aGUgd29ybGQsICB8CnwgYnV0
IHRoZXkncmUgbm90IHwKfCBnaXZpbmcgbWUgdGhlICAgfAogXCBzb3VyY2UgY29kZSEgIC8KICAt
LS0tLS0tLS0tLS0tLS0KICAgIMKvXF8o44OEKV8vwq8KCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
