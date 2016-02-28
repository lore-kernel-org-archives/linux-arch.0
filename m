From: Markus Trippelsdorf via llvm-dev <llvm-dev@lists.llvm.org>
Subject: Re: [isocpp-parallel] Proposal for new
 memory_order_consume definition
Date: Sun, 28 Feb 2016 09:27:02 +0100
Message-ID: <20160228082702.GA300@x4>
References: <20160218011033.GA1505@linux.vnet.ibm.com>
 <20160220021516.4898897.32908.5212@gmail.com>
 <20160220195318.GF3522@linux.vnet.ibm.com>
 <CAPUmR1bw=N4NkjAK1zn_X0+84KEaEAM6HZCHZJy_txqC9hMgSg@mail.gmail.com>
 <20160227170615.GU3522@linux.vnet.ibm.com>
 <CA+55aFyHmykKc=YybJMo9ZUO352MY5noJVB4-K1Lkjmw4UHXfA@mail.gmail.com>
 <20160227231033.GW3522@linux.vnet.ibm.com>
Reply-To: Markus Trippelsdorf <markus@trippelsdorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <llvm-dev-bounces@lists.llvm.org>
Content-Disposition: inline
In-Reply-To: <20160227231033.GW3522@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.llvm.org/cgi-bin/mailman/options/llvm-dev>,
 <mailto:llvm-dev-request@lists.llvm.org?subject=unsubscribe>
List-Archive: <http://lists.llvm.org/pipermail/llvm-dev/>
List-Post: <mailto:llvm-dev@lists.llvm.org>
List-Help: <mailto:llvm-dev-request@lists.llvm.org?subject=help>
List-Subscribe: <http://lists.llvm.org/cgi-bin/mailman/listinfo/llvm-dev>,
 <mailto:llvm-dev-request@lists.llvm.org?subject=subscribe>
Errors-To: llvm-dev-bounces@lists.llvm.org
Sender: "llvm-dev" <llvm-dev-bounces@lists.llvm.org>
To: paulmck@linux.vnet.ibm.com
Cc: linux-arch@vger.kernel.org, gcc@gcc.gnu.org, parallel@lists.isocpp.org, llvm-dev@lists.llvm.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, peterz@infradead.org, Ramana.Radhakrishnan@arm.com, Luc Maranget <luc.maranget@inria.fr>, akpm@linux-foundation.org, Jade Alglave <j.alglave@ucl.ac.uk>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

T24gMjAxNi4wMi4yNyBhdCAxNToxMCAtMDgwMCwgUGF1bCBFLiBNY0tlbm5leSB2aWEgbGx2bS1k
ZXYgd3JvdGU6Cj4gT24gU2F0LCBGZWIgMjcsIDIwMTYgYXQgMTE6MTY6NTFBTSAtMDgwMCwgTGlu
dXMgVG9ydmFsZHMgd3JvdGU6Cj4gPiBPbiBGZWIgMjcsIDIwMTYgMDk6MDYsICJQYXVsIEUuIE1j
S2VubmV5IiA8cGF1bG1ja0BsaW51eC52bmV0LmlibS5jb20+Cj4gPiB3cm90ZToKPiA+ID4KPiA+
ID4KPiA+ID4gQnV0IHdlIGRvIGFscmVhZHkgaGF2ZSBzb21ldGhpbmcgdmVyeSBzaW1pbGFyIHdp
dGggc2lnbmVkIGludGVnZXIKPiA+ID4gb3ZlcmZsb3cuICBJZiB0aGUgY29tcGlsZXIgY2FuIHNl
ZSBhIHdheSB0byBnZW5lcmF0ZSBmYXN0ZXIgY29kZSB0aGF0Cj4gPiA+IGRvZXMgbm90IGhhbmRs
ZSB0aGUgb3ZlcmZsb3cgY2FzZSwgdGhlbiB0aGUgc2VtYW50aWNzIHN1ZGRlbmx5IGNoYW5nZQo+
ID4gPiBmcm9tIHR3b3MtY29tcGxlbWVudCBhcml0aG1ldGljIHRvIHNvbWV0aGluZyB2ZXJ5IHN0
cmFuZ2UuICBUaGUgc3RhbmRhcmQKPiA+ID4gZG9lcyBub3Qgc3BlY2lmeSBhbGwgdGhlIHdheXMg
dGhhdCB0aGUgaW1wbGVtZW50YXRpb24gbWlnaHQgZGVkdWNlIHRoYXQKPiA+ID4gZmFzdGVyIGNv
ZGUgY2FuIGJlIGdlbmVyYXRlZCBieSBpZ25vcmluZyB0aGUgb3ZlcmZsb3cgY2FzZSwgaXQgaW5z
dGVhZAo+ID4gPiBzaW1wbHkgc2F5cyB0aGF0IHNpZ25lZCBpbnRlZ2VyIG92ZXJmbG93IGludm9r
ZWQgdW5kZWZpbmVkIGJlaGF2aW9yLgo+ID4gPgo+ID4gPiBBbmQgaWYgdGhhdCBpcyBhIHByb2Js
ZW0sIHlvdSB1c2UgdW5zaWduZWQgaW50ZWdlcnMgaW5zdGVhZCBvZiBzaWduZWQKPiA+ID4gaW50
ZWdlcnMuCj4gPiAKPiA+IEFjdHVhbGx5LCBpbiB0aGUgY2FzZSBvZiB0aGVyZSBMaW51eCBrZXJu
ZWwgd2UganVzdCB0ZWxsIHRoZSBjb21waWxlciB0bwo+ID4gbm90IGJlIGFuIGFzcy4gV2UgdXNl
Cj4gPiAKPiA+ICAgLWZuby1zdHJpY3Qtb3ZlcmZsb3cKPiAKPiBUaGF0IGlzIHRoZSBvbmUhCj4g
Cj4gPiBvciBzb21ldGhpbmcuIEkgZm9yZ2V0IHRoZSBleGFjdCBjb21waWxlciBmbGFnIG5lZWRl
ZCBmb3IgInRoZSBzdGFuZGFyZCBpcwo+ID4gYXMgYnJva2VuIHBpZWNlIG9mIHNoaXQgYW5kIG1h
ZGUgdGhpbmdzIHVuZGVmaW5lZCBmb3IgdmVyeSBiYWQgcmVhc29ucyIuCj4gPiAKPiA+IFNlZSBh
bHNvIHRoZXJlIGlkaW90aWMgc3RhbmRhcmQgQyBhbGlhcyBydWxlcy4gU2FtZSBkZWFsLgo+IAo+
IEZvciB3aGljaCB3ZSB1c2UgLWZuby1zdHJpY3QtYWxpYXNpbmcuCgpEbyBub3QgZm9yZ2V0IC1m
bm8tZGVsZXRlLW51bGwtcG9pbnRlci1jaGVja3MuIAoKU28gdGhlIGtlcm5lbCBvYnZpb3VzbHkg
aXMgYWxyZWFkeSB1c2luZyBpdHMgb3duIEMgZGlhbGVjdCwgdGhhdCBpcwpwcmV0dHkgZmFyIGZy
b20gc3RhbmRhcmQgQy4KQWxsIHRoZXNlIG9wdGlvbnMgYWxzbyBoYXZlIGEgbmVnYXRpdmUgaW1w
YWN0IG9uIHRoZSBwZXJmb3JtYW5jZSBvZiB0aGUKZ2VuZXJhdGVkIGNvZGUuCgotLSAKTWFya3Vz
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxMVk0gRGV2
ZWxvcGVycyBtYWlsaW5nIGxpc3QKbGx2bS1kZXZAbGlzdHMubGx2bS5vcmcKaHR0cDovL2xpc3Rz
Lmxsdm0ub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sbHZtLWRldgo=
