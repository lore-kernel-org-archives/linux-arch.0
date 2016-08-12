From: Kees Cook <keescook@chromium.org>
Subject: Re: [RFC v3 07/13] tables.h: add linker table support
Date: Fri, 12 Aug 2016 11:16:46 -0700
Message-ID: <CAGXu5j+YFgZaB44phFcfsRkmc0tDn2iKqWy=s2tmC-vVzgqXng@mail.gmail.com>
References: <20160729100630.GA27271@nazgul.tnic>
 <20160808150539.GG3296@wotan.suse.de>
 <20160809035508.GC11445@nazgul.tnic> <20160812035129.GA3296@wotan.suse.de>
 <20160812052303.GB12013@nazgul.tnic> <20160812065011.GB3296@wotan.suse.de>
 <20160812072507.GC12013@nazgul.tnic> <20160812152805.GD3296@wotan.suse.de>
 <20160812155121.GB13315@nazgul.tnic> <20160812170451.GE3296@wotan.suse.de>
 <20160812173507.GC13315@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <20160812173507.GC13315@nazgul.tnic>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>, linux-ia64@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, Ming Lei <ming.lei@canonical.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, platform-driver-x86@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, linux-arch <linux-arch@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-sh <linux-sh@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, korea.drzix@gmail.com, "x86@kernel.org" <x86@kernel.org>, anil.s.keshavamurthy@intel.com, fontana@sharpeleven.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.>
List-Id: linux-arch.vger.kernel.org

SnVzdCBzb21lIG1pbm9yIHR5cG9zIGluIGRlc2NyaXB0aW9ucyBJIG5vdGljZWQgYmVsb3cuLi4K
Ck9uIEZyaSwgQXVnIDEyLCAyMDE2IGF0IDEwOjM1IEFNLCBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFs
aWVuOC5kZT4gd3JvdGU6Cj4gT24gRnJpLCBBdWcgMTIsIDIwMTYgYXQgMDc6MDQ6NTJQTSArMDIw
MCwgTHVpcyBSLiBSb2RyaWd1ZXogd3JvdGU6Cj4+IEFscmlnaHQsIGhvdydzIHRoaXMgbmV3IGRl
c2NyaXB0aW9uOgo+Pgo+PiBkaWZmIC0tZ2l0IGEvaW5pdC9LY29uZmlnIGIvaW5pdC9LY29uZmln
Cj4+IGluZGV4IGNhYzNmMDk2MDUwZC4uNzNlNDg5MGMyNGM0IDEwMDY0NAo+PiAtLS0gYS9pbml0
L0tjb25maWcKPj4gKysrIGIvaW5pdC9LY29uZmlnCj4+IEBAIC01Myw2ICs1MywzNCBAQCBjb25m
aWcgQ1JPU1NfQ09NUElMRQo+PiAgICAgICAgIG5lZWQgdG8gc2V0IHRoaXMgdW5sZXNzIHlvdSB3
YW50IHRoZSBjb25maWd1cmVkIGtlcm5lbCBidWlsZAo+PiAgICAgICAgIGRpcmVjdG9yeSB0byBz
ZWxlY3QgdGhlIGNyb3NzLWNvbXBpbGVyIGF1dG9tYXRpY2FsbHkuCj4+Cj4+ICtjb25maWcgQlVJ
TERfQVZPSURfQklUUk9UCj4+ICsgICAgIGJvb2wgIkFsd2F5cyBmb3JjZSBidWlsZGluZyBzcGVj
aWFsbHkgYW5ub3RhdGVkIHRhcmdldHMiCj4+ICsgICAgIGRlZmF1bHQgbgo+PiArICAgICBoZWxw
Cj4+ICsgICAgICAgSWYgZW5hYmxlZCB0aGVuIHRoZSB0aGUgc3BlY2lhbCB0YWJsZS0qIE1ha2Vm
aWxlIHRhcmdldHMgd2lsbCBhbHdheXMKCiJ0aGUgdGhlIiAtPiAidGhlIgoKPj4gKyAgICAgICBi
ZSBmb3JjZWQgdG8gYmUgY29tcGlsZWQgZXZlbiBpZiB0aGVpciByZXNwZWN0aXZlIENPTkZJR18g
b3B0aW9uIGhhcwo+Cj4gIndpbGwgYWx3YXlzIGJlIGNvbXBpbGVkIiBpcyBhbHJlYWR5IGFic29s
dXRlLgo+Cj4+ICsgICAgICAgYmVlbiBkaXNhYmxlZCwgYnV0IGl0cyBvYmplY3RzIHdpbGwgb25s
eSBiZSBsaW5rZWQgaW4gaWYgdGhlIHNhbWUKPj4gKyAgICAgICByZXNwZWN0aXZlIENPTkZJR18g
b3B0aW9uIGhhcyBiZWVuIGVuYWJsZWQuIFRoaXMgaGVscHMgYXZvaWQgY29kZQo+PiArICAgICAg
IGJpdCByb3QgaXNzdWVzLCB1c2UgZm9yIHRoZXNlIHRhcmdldHMgc2hvdWxkIGJlIGNhcmVmdWxs
eSBjb25zaWRyZWQKCiJjb25zaWRlcmVkIgoKPgo+IHMvVGhpcyBoZWxwcyBhdm9pZCBjb2RlIGJp
dCByb3QgaXNzdWVzLCB1L1UvCj4KPiBUaGUgYml0LXJvdCB0aGluZyBjb21lcyBhZ2FpbiBiZWxv
dy4KPgo+PiArICAgICAgIGJ5IG1haW50YWluZXJzLiBZb3UgY2FuIHNhZmVseSBlbmFibGUgdGhp
cyBvcHRpb24gYXQgdGhlIGV4cGVuc2Ugb2YKPj4gKyAgICAgICBpbmNyZWFzaW5nIGNvbXBpbGUg
dGltZS4gRW5hYmxpbmcgdGhpcyBvcHRpb24gaGVscHMgYXZvaWQgY29kZSBiaXQKPj4gKyAgICAg
ICByb3QgYnkgdGFraW5nIGFkdmFudGFnZSBvZiB0aGUgZmFjaWxpdGllcyBwcm92aWRlZCBhbmQg
ZW5hYmxlZCBieQo+PiArICAgICAgIHVzaW5nIGxpbmtlciB0YWJsZXMgZG9jdW1lbnRlZCB1bmRl
cjoKPj4gKwo+PiArICAgICAgIGluY2x1ZGUvbGludXgvdGFibGVzLmgKPj4gKwo+PiArICAgICAg
IFRoZSBzcGVjaWFsIHRhcmdldHMgc3VwcG9ydGVkIGFyZToKPj4gKwo+PiArICAgICAgICAgbyB0
YWJsZS1vYmoteQo+PiArICAgICAgICAgbyB0YWJsZS1saWIteQo+PiArCj4+ICsgICAgICAgU2F5
IFkgaWYgeW91IGhhdmUgYSBkZWNlbnQgYnVpbGQgbWFjaGluZSBhbmQgd291bGQgbGlrZSB0byBo
ZWxwIHRlc3QKPj4gKyAgICAgICBidWlsZGluZyBjb2RlIGZvciBtb3JlIHN1YnN5c3RlbXMuIFNh
eSBOIGlmIHlvdSBkbyB5b3Ugbm90IGhhdmUgYQo+PiArICAgICAgIGdvb2QgYnVpbGQgbWFjaGlu
ZSBvciBvbmx5IHdhbnQgdG8gY29tcGlsZSB3aGF0IHlvdSd2ZSBlbmFibGVkIGZvcgo+PiArICAg
ICAgIHlvdXIga2VybmVsLgo+PiArCj4+ICsgICAgICAgRW5hYmxpbmcgdGhpcyBvcHRpb24gbmV2
ZXIgaW5jcmVhc2VzIHRoZSBzaXplIG9mIHlvdXIga2VybmVsLgo+PiArCj4KPiBPdGhlciB0aGFu
IHRob3NlIG1pbm9yIGZvcm11bGF0aW9uIG5pdHMsIHllYWgsIG5pY2UhCj4KPiBUaGFua3MuCj4K
PiAtLQo+IFJlZ2FyZHMvR3J1c3MsCj4gICAgIEJvcmlzLgo+Cj4gRUNPIHRpcCAjMTAxOiBUcmlt
IHlvdXIgbWFpbHMgd2hlbiB5b3UgcmVwbHkuCj4gLS0KCi1LZWVzCgotLSAKS2VlcyBDb29rCk5l
eHVzIFNlY3VyaXR5CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpYZW4tZGV2ZWwgbWFpbGluZyBsaXN0Clhlbi1kZXZlbEBsaXN0cy54ZW4ub3JnCmh0dHBz
Oi8vbGlzdHMueGVuLm9yZy94ZW4tZGV2ZWwK
