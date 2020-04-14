From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
Date: Tue, 14 Apr 2020 14:28:35 +0200
Message-ID: <36616218-1d3a-b18a-8fb8-4fc9eff22780@c-s.fr>
References: <20200413125303.423864-1-npiggin@gmail.com>
 <20200413125303.423864-5-npiggin@gmail.com>
 <20200413134106.GN21484@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200413134106.GN21484@bombadil.infradead.org>
Content-Language: fr
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Matthew Wilcox <willy@infradead.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

CgpMZSAxMy8wNC8yMDIwIMOgIDE1OjQxLCBNYXR0aGV3IFdpbGNveCBhIMOpY3JpdMKgOgo+IE9u
IE1vbiwgQXByIDEzLCAyMDIwIGF0IDEwOjUzOjAzUE0gKzEwMDAsIE5pY2hvbGFzIFBpZ2dpbiB3
cm90ZToKPj4gK3N0YXRpYyBpbnQgdm1hcF9wYWdlc19yYW5nZV9ub2ZsdXNoKHVuc2lnbmVkIGxv
bmcgc3RhcnQsIHVuc2lnbmVkIGxvbmcgZW5kLAo+PiArCQkJCSAgICBwZ3Byb3RfdCBwcm90LCBz
dHJ1Y3QgcGFnZSAqKnBhZ2VzLAo+PiArCQkJCSAgICB1bnNpZ25lZCBpbnQgcGFnZV9zaGlmdCkK
Pj4gK3sKPj4gKwlpZiAocGFnZV9zaGlmdCA9PSBQQUdFX1NJWkUpIHsKPiAKPiAuLi4gSSB0aGlu
ayB5b3UgbWVhbnQgJ3BhZ2Vfc2hpZnQgPT0gUEFHRV9TSElGVCcKPiAKPiBPdmVyYWxsIEkgbGlr
ZSB0aGlzIHNlcmllcywgYWx0aG91Z2ggaXQncyBhIGJpdCBiaWFzZWQgdG93YXJkcyBDUFVzCj4g
d2hpY2ggaGF2ZSBwYWdlIHNpemVzIHdoaWNoIG1hdGNoIFBNRC9QVUQgc2l6ZXMuICBJdCBkb2Vz
bid0IG9mZmVyIHRoZQo+IHBvc3NpYmlsaXR5IG9mIHVzaW5nIDY0a0IgcGFnZSBzaXplcyBvbiBB
Uk0sIGZvciBleGFtcGxlLiAgQnV0IGl0J3MgYQo+IHN0ZXAgaW4gdGhlIHJpZ2h0IGRpcmVjdGlv
bi4KPiAKCkkgd2FzIGdvaW5nIHRvIGFzayBtb3JlIG9yIGxlc3MgdGhlIHNhbWUgcXVlc3Rpb24s
IEkgd291bGQgaGF2ZSBsaWtlZCB0byAKdXNlIDUxMmtCIGh1Z2VwYWdlcyBvbiBwb3dlcnBjIDh4
eC4KCkV2ZW4gdGhlIDhNIGh1Z2VwYWdlcyAoc3RpbGwgb24gdGhlIDh4eCksIGNhbiB0aGV5IGJl
IHVzZWQgYXMgd2VsbCwgCnRha2luZyBpbnRvIGFjY291bnQgdGhhdCB0d28gUEdEIGVudHJpZXMg
aGF2ZSB0byBwb2ludCB0byB0aGUgc2FtZSA4TSBwYWdlID8KCkkgc2VudCBvdXQgYSBzZXJpZXMg
d2hpY2ggdGVuZHMgdG8gbWFrZSB0aGUgbWFuYWdlbWVudCBvZiA1MTJrIGFuZCA4TSAKcGFnZXMg
Y2xvc2VyIHRvIHdoYXQgTGludXggZXhwZWN0cywgaW4gb3JkZXIgdG8gdXNlIHRoZW0gaW5zaWRl
IGtlcm5lbCwgCmZvciBMaW5lYXIgbWFwcGluZ3MgYW5kIEthc2FuIG1hcHBpbmdzIGZvciB0aGUg
bW9tZW50LiBTZWUgCmh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9saW51eHBw
Yy1kZXYvbGlzdC8/c2VyaWVzPTE2NDYyMApJdCB3b3VsZCBiZSBuaWNlIGlmIHdlIGNvdWxkIGFt
cGxpZnkgaXQgYSB1c2UgaXQgZm9yIGlvcmVtYXBzIGFuZCAKdm1hbGxvY3MgYXMgd2VsbC4KCkNo
cmlzdG9waGUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
