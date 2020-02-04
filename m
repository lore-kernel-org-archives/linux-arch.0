From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Date: Tue, 4 Feb 2020 18:27:58 +0100
Message-ID: <20200204172758.GF14879@hirez.programming.kicks-ass.net>
References: <8D3AFB47-B595-418C-9568-08780DDC58FF@oracle.com>
 <714892cd-d96f-4d41-ae8b-d7b7642a6e3c@redhat.com>
 <1669BFDE-A1A5-4ED8-B586-035460BBF68A@oracle.com>
 <20200125111931.GW11457@worktop.programming.kicks-ass.net>
 <F32558D8-4ACB-483A-AB4C-F565003A02E7@oracle.com>
 <20200203134540.GA14879@hirez.programming.kicks-ass.net>
 <6d11b22b-2fb5-7dea-f88b-b32f1576a5e0@redhat.com>
 <20200203152807.GK14914@hirez.programming.kicks-ass.net>
 <15fa978d-bd41-3ecb-83d5-896187e11244@redhat.com>
 <83762715-F68C-42DF-9B41-C4C48DF6762F@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <83762715-F68C-42DF-9B41-C4C48DF6762F@oracle.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux-arch@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>, Arnd Bergmann <arnd@arndb.de>, dave.dice@oracle.com, Jan Glauber <jglauber@marvell.com>, x86@kernel.org, Will Deacon <will.deacon@arm.com>, linux@armlinux.org.uk, Steven Sistare <steven.sistare@oracle.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, hpa@zytor.com, Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

T24gVHVlLCBGZWIgMDQsIDIwMjAgYXQgMTE6NTQ6MDJBTSAtMDUwMCwgQWxleCBLb2dhbiB3cm90
ZToKPiA+IE9uIEZlYiAzLCAyMDIwLCBhdCAxMDo0NyBBTSwgV2FpbWFuIExvbmcgPGxvbmdtYW5A
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiAKPiA+IE9uIDIvMy8yMCAxMDoyOCBBTSwgUGV0ZXIgWmlq
bHN0cmEgd3JvdGU6Cj4gPj4gT24gTW9uLCBGZWIgMDMsIDIwMjAgYXQgMDk6NTk6MTJBTSAtMDUw
MCwgV2FpbWFuIExvbmcgd3JvdGU6Cj4gPj4+IE9uIDIvMy8yMCA4OjQ1IEFNLCBQZXRlciBaaWps
c3RyYSB3cm90ZToKPiA+Pj4+IFByZXN1bWFibHkgeW91IGhhdmUgYSB3b3JrbG9hZCB3aGVyZSBD
TkEgaXMgYWN0dWFsbHkgYSB3aW4/IFRoYXQgaXMsCj4gPj4+PiB3aGF0IGluc3BpcmVkIHlvdSB0
byBnbyBkb3duIHRoaXMgcm9hZD8gV2hpY2ggYWN0dWFsIGtlcm5lbCBsb2NrIGlzIHNvCj4gPj4+
PiBjb250ZW5kZWQgb24gTlVNQSBtYWNoaW5lcyB0aGF0IHdlIG5lZWQgdG8gZG8gdGhpcz8KCj4g
VGhlcmUgYXJlIHF1aXRlIGEgZmV3IGFjdHVhbGx5LiBmaWxlc19zdHJ1Y3QuZmlsZV9sb2NrLCBm
aWxlX2xvY2tfY29udGV4dC5mbGNfbG9jawo+IGFuZCBsb2NrcmVmLmxvY2sgYXJlIHNvbWUgY29u
Y3JldGUgZXhhbXBsZXMgdGhhdCBnZXQgdmVyeSBob3QgaW4gd2lsbC1pdC1zY2FsZQo+IGJlbmNo
bWFya3MuIAoKUmlnaHQsIHRoYXQncyBhbGwgYSB2YXJpYW50IG9mIGJhbmdpbmcgb24gdGhlIHNh
bWUgcmVzb3VyY2VzIGFjcm9zcwpub2Rlcy4gSSdtIG5vdCBzdXJlIHRoZXJlJ3MgYW55dGhpbmcg
ZnVuZGFtZW50YWwgd2UgY2FuIGZpeCB0aGVyZS4KCj4gQW5kIHRoZW4gdGhlcmUgYXJlIHNwaW5s
b2NrcyBpbiBfX2Z1dGV4X2RhdGEucXVldWVzLCAKPiB3aGljaCBnZXQgaG90IHdoZW4gYXBwbGlj
YXRpb25zIGhhdmUgY29udGVuZGVkIChwdGhyZWFkKSBsb2NrcyDigJQgCj4gTGV2ZWxEQiBpcyBh
biBleGFtcGxlLgoKQSBudW1hIGF3YXJlIHJld29yayBvZiBmdXRleGVzIGhhcyBiZWVuIG9uIHRo
ZSB0b2RvIGxpc3QgZm9yIHllYXJzIDovCgo+IE91ciBpbml0aWFsIG1vdGl2YXRpb24gd2FzIGJh
c2VkIG9uIGFuIG9ic2VydmF0aW9uIHRoYXQga2VybmVsIHFzcGlubG9jayBpcyBub3QgCj4gTlVN
QS1hd2FyZS4gU28gd2hhdCwgeW91IG1heSBhc2suIE11Y2ggbGlrZSBwZW9wbGUgcmVhbGl6ZWQg
aW4gdGhlIHBhc3QgdGhhdAo+IGdsb2JhbCBzcGlubmluZyBpcyBiYWQgZm9yIHBlcmZvcm1hbmNl
LCBhbmQgdGhleSBzd2l0Y2hlZCBmcm9tIHRpY2tldCBsb2NrIHRvCj4gbG9ja3Mgd2l0aCBsb2Nh
bCBzcGlubmluZyAoZS5nLiwgTUNTKSwgSSB0aGluayBldmVyeW9uZSB3b3VsZCBhZ3JlZSB0aGVz
ZSBkYXlzIHRoYXQKPiBib3VuY2luZyBhIGxvY2sgKGFuZCBjYWNoZSBsaW5lcyBpbiBnZW5lcmFs
KSBhY3Jvc3MgbnVtYSBub2RlcyBpcyBzaW1pbGFybHkgYmFkLgo+IEFuZCBhcyBDTkEgZGVtb25z
dHJhdGVzLCB3ZSBhcmUgZWFzaWx5IGxlYXZpbmcgMi0zeCBzcGVlZHVwcyBvbiB0aGUgdGFibGUg
YnkKPiBkb2luZyBqdXN0IHRoYXQgd2l0aCB0aGUgY3VycmVudCBxc3BpbmxvY2suCgpBY3R1YWwg
YmVuY2htYXJrcyB3aXRoIHBlcmZvcm1hbmNlIG51bWJlcnMgYXJlIHJlcXVpcmVkLiBJdCBoZWxw
cwptb3RpdmF0ZSB0aGUgcGF0Y2hlcyBhcyB3ZWxsIGFzIGdpdmVzIHJldmlld2VycyBjbHVlcyBv
biBob3cgdG8KcmVwcm9kdWNlIC8gaW5zcGVjdCB0aGUgY2xhaW1zIG1hZGUuCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
