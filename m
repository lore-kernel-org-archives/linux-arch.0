From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v4 07/16] tables.h: add linker table support
Date: Tue, 23 Aug 2016 01:53:12 +0200
Message-ID: <20160822235312.GV3296@wotan.suse.de>
References: <1471642385-5629-1-git-send-email-mcgrof@kernel.org>
 <1471642385-5629-8-git-send-email-mcgrof@kernel.org>
 <CAGXu5jLWv0V8GkvCzGmydRNqp2ppXqfMzJHgnd5cCtsbVo8qjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <CAGXu5jLWv0V8GkvCzGmydRNqp2ppXqfMzJHgnd5cCtsbVo8qjA@mail.gmail.com>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: Kees Cook <keescook@chromium.org>
Cc: "gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>, linux-ia64@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, Ming Lei <ming.lei@canonical.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, platform-driver-x86@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, linux-arch <linux-arch@vger.kernel.org>, markus.heiser@darmarit.de, sparclinux <sparclinux@vger.kernel.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-sh <linux-sh@vger.kernel.org>, Will Deacon <will>
List-Id: linux-arch.vger.kernel.org

T24gRnJpLCBBdWcgMTksIDIwMTYgYXQgMDM6MDI6MDdQTSAtMDcwMCwgS2VlcyBDb29rIHdyb3Rl
Ogo+IE9uIEZyaSwgQXVnIDE5LCAyMDE2IGF0IDI6MzIgUE0sICA8bWNncm9mQGtlcm5lbC5vcmc+
IHdyb3RlOgo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYzZ4L2luY2x1ZGUvYXNtL3RhYmxlcy5oIGIv
YXJjaC9jNngvaW5jbHVkZS9hc20vdGFibGVzLmgKPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4g
PiBpbmRleCAwMDAwMDAwMDAwMDAuLjA5YTllMzFjNTczYQo+ID4gLS0tIC9kZXYvbnVsbAo+ID4g
KysrIGIvYXJjaC9jNngvaW5jbHVkZS9hc20vdGFibGVzLmgKPiA+IEBAIC0wLDAgKzEsMjYgQEAK
PiA+ICsjaWZuZGVmIF9BU01fQzZYX0FTTV9UQUJMRVNfSAo+ID4gKyNkZWZpbmUgX0FTTV9DNlhf
QVNNX1RBQkxFU19ICj4gPiArLyoKPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMTYgTHVpcyBSLiBS
b2RyaWd1ZXogPG1jZ3JvZkBrZXJuZWwub3JnPgo+ID4gKyAqCj4gPiArICogVGhpcyBwcm9ncmFt
IGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkg
aXQKPiA+ICsgKiB1bmRlciB0aGUgdGVybXMgb2YgY29weWxlZnQtbmV4dCAodmVyc2lvbiAwLjMu
MSBvciBsYXRlcikgYXMgcHVibGlzaGVkCj4gPiArICogYXQgaHR0cDovL2NvcHlsZWZ0LW5leHQu
b3JnLy4KPiA+ICsgKi8KPiA+ICsKPiA+ICsvKgo+ID4gKyAqIFRoZSBjNnggdG9vbGNoYWluIGhh
cyBhIGJ1ZyBwcmVzZW50IGV2ZW4gb24gZ2NjLTYgd2hlbiBub24td2VhayBhdHRyaWJ1dGVzCj4g
PiArICogYXJlIHVzZWQgYW5kIHNlbmRzIHRoZW0gdG8gLnJvZGF0YSBldmVuIHRob3VnaCBjb25z
dCBkYXRhIHdpdGggd2Vhawo+ID4gKyAqIGF0dHJpYnV0ZXMgYXJlIHB1dCBpbiAuY29uc3QsIHRo
aXMgZm9yY2VzIHRoZSBsaW5rZXIgdG8gYmVsaWV2ZSB0aGUgYWRkcmVzcwo+ID4gKyAqIGlzIHJl
bGF0aXZlIHJlbGF0aXZlIHRvIHRoZSBhIGJhc2UgKyBvZmZzZXQgYW5kIHlvdSBlbmQgdXAgd2l0
aCBTQi1yZWxhdGl2ZQo+ID4gKyAqIHJlbG9jIGVycm9yIHVwb24gbGlua2luZy4gV29yayBhcm91
bmQgdGhpcyBieSBieSBmb3JjaW5nIGJvdGggc3RhcnQgYW5kCj4gPiArICogZW5kaW5nIGNvbnN0
IFJPIHdhZWsgbGlua2VyIHRhYmxlIGVudHJ5IHRvIGJlIC5jb25zdCB0byBmaXggdGhpcyBmb3Ig
bm93Lgo+IAo+IFR5cGU6IHdhZWsgLT4gd2VhawoKVGhhbmtzLCBmaXhlZC4KCiAgTHVpcwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KWGVuLWRldmVsIG1h
aWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVuLm9yZwpodHRwczovL2xpc3RzLnhlbi5vcmcv
eGVuLWRldmVsCg==
