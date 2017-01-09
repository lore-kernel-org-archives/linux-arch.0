From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v6 00/14] linux: generalize sections,
	ranges and linker tables
Date: Mon, 9 Jan 2017 10:36:20 -0600
Message-ID: <CAB=NE6XZCfiZhK887ybB6QpY-_3SMMUu1dLR+3ft7hHbmqaOkw@mail.gmail.com>
References: <20161222023811.21246-1-mcgrof@kernel.org>
 <20170109145833.11502-1-mcgrof@kernel.org>
 <1483979228.26691.40.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1483979228.26691.40.camel@linux.intel.com>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, dalias@libc.org, linux-ia64@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ming Lei <ming.lei@canonical.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, platform-driver-x86@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Wang Nan <wangnan0@huawei.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, linux-arch <linux-arch@vger.kernel.org>, markus.heiser@darmarit.de, sparclinux@vger.kernel.org, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Russell King <linux@arm.linux.org.uk>, linux-sh@vger.kernel.org, Will Deacon <wil>
List-Id: linux-arch.vger.kernel.org

T24gTW9uLCBKYW4gOSwgMjAxNyBhdCAxMDoyNyBBTSwgQW5keSBTaGV2Y2hlbmtvCjxhbmRyaXku
c2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+IHdyb3RlOgo+IE9uIE1vbiwgMjAxNy0wMS0wOSBh
dCAwNjo1OCAtMDgwMCwgTHVpcyBSLiBSb2RyaWd1ZXogd3JvdGU6Cj4+IFRoZSBvbmx5IGFyY2hp
dGVjdHVyZSB0aGF0IHdhcyBub3QgdGVzdGVkIHdhcyBhdnIzMiBhbmQgdGhhdCBpcwo+PiBiZWNh
dXNlIGxpbnV4LW5leHQgZmFpbHMgdG8gY29tcGlsZSBvbiBpdC4gSSdkIGxpa2UgdG8gZ3JlYXRs
eSB0aGFuayBHdWVudGVyCj4+IFJvZWNrIGZvciBoaXMgaGVscCB3aXRoIHRlc3RpbmcuCj4KPiBX
ZSBoYXZlIGEgcmVhbCBib2FyZCBoZXJlLiBJIHdvdWxkIHRyeSB0byBjaGVjayBpZiB5b3UgcHJv
dmlkZSBhIGdpdCB1cmwKPiB0byB5b3VyIHN0dWZmLgoKSSBwcm92aWRlZCB0aGUgZ2l0IFVSTCBi
ZWxvdywgSSB3aWxsIGhpZ2hsaWdodCBpdCBiZWxvdyBhZ2Fpbi4KCj4gSSBjYW4gY29uZmlybSB0
aGF0IGJyZWFrYWdlIGhhcHBlbmVkIGxpa2UgaW4gbGFzdCBjb3VwbGUgb2YgbW9udGguCj4gdjQu
MTAtcmMzIGNhbid0IGJlIGNvbXBpbGVkIGVpdGhlci4KCllvdSBtZWFuIGFuIGF2cjMyIGJvYXJk
ID8KCj4+IFRoZSBkZWJ1ZyBwYXRjaCB3aGljaCBmb3JjZSBlbmFibGVzIHRoZSB0ZXN0IGRyaXZl
ciBpcyBub3Qgc3VibWl0dGVkCj4+IGZvcgo+PiB1cHN0cmVhbSBpbmNsdXNpb24gYnV0IGlzIGtl
cHQgYXMgcGFydCBvZiB0aGUgcHVibGljIHRyZWUgZm9yIHRob3NlCj4+IGN1cmlvdXMsCj4+IGl0
cyB0aGUgbGFzdCBwYXRjaCBbMV0uIFRoaXMgdHJlZSBpcyBiYXNlZCBvbiBsaW51eC1uZXh0IHRh
ZyBuZXh0LQo+PiAyMDE3MDEwOS4KPj4KPj4gWzBdIGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3Iv
MjAxNjEyMjIwMjM4MTEuMjEyNDYtMS1tY2dyb2ZAa2VybmVsLm9yZwo+PiBbMV0gaHR0cHM6Ly9n
aXQua2VybmVsLm9yZy9jZ2l0L2xpbnV4L2tlcm5lbC9naXQvbWNncm9mL2xpbnV4LQo+PiBuZXh0
LmdpdC9sb2cvP2g9MjAxNzAxMDktbGlua2VyLXRhYmxlcy12NgoKSGVyZSBpcyB0aGUgZ2l0IHRy
ZWUsIG5vdGUgbGFzdCBwYXRjaCBpcyBhIGRlYnVnIHBhdGNoIHdoaWNoIHdhcyBub3QKc3VibWl0
dGVkLCBpdCBmb3JjZSBlbmFibGVzIHRoZSBkZWJ1ZyB0ZXN0IGxpbmt0YWJsZSBwYXRjaCwgeW91
IGRvCndhbnQgdGhhdCBmb3IgeW91ciB0ZXN0aW5nIHRob3VnaC4KCj4gU2VyaWVzIGlzIGZpbmUg
dG8gbWUKPgo+IEZXSVc6Cj4gUmV2aWV3ZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNo
ZXZjaGVua29AbGludXguaW50ZWwuY29tPgoKR3JlYXQgdGhhbmtzIGZvciB0aGUgcmV2aWV3IQoK
ICBMdWlzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpY
ZW4tZGV2ZWwgbWFpbGluZyBsaXN0Clhlbi1kZXZlbEBsaXN0cy54ZW4ub3JnCmh0dHBzOi8vbGlz
dHMueGVuLm9yZy94ZW4tZGV2ZWwK
