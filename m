From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Software prefetching considered harmful
Date: Thu, 19 May 2011 10:12:22 -0700
Message-ID: <BANLkTim5MaJBYSuTnXfmOjgPNVOyZSgQuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec52be6e5ed9d7b04a3a41c2b
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52960 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933540Ab1ESRNP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 May 2011 13:13:15 -0400
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p4JHCg4a011195
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <linux-arch@vger.kernel.org>; Thu, 19 May 2011 10:12:43 -0700
Received: by ewy4 with SMTP id 4so888761ewy.19
        for <linux-arch@vger.kernel.org>; Thu, 19 May 2011 10:12:42 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

--bcaec52be6e5ed9d7b04a3a41c2b
Content-Type: text/plain; charset=ISO-8859-1

So I spent some time the last few days looking at kernel performance
on a load that I personally see all the time: "make" on a tree that is
pretty much fully built. So we don't have the actual cost of
compilation, just the cost of _checking_ what needs to be compiled.

It turns out that "make" is pretty piggish (what else is new), but
this is actually a fairly kernel-intensive load: there's a fair amount
of time spent in filename lookup. And we're doing very well in the
filename lookup, except now that I can enable SELinux and not lose the
advantage of RCU lookup, I see selinux - and particularly AVC -
sucking dead donkey fetuses through a straw.

However, the top offender in the top function (avc_has_perm_noaudit())
was actually our generic hlist software prefetching use. On both my
Atom laptop (which I was compiling kernels on because I was off
getting my master diver certification) and on my workstation Core-i5
670, the profiles clearly showed the prefetch instruction to be the
top offender by far.

And it's not because it gets all the cache misses. Removing the
prefetch actually IMPROVES PERFORMANCE.

It turns out that apparently the prefetch causes problems for the
pipeline when it doesn't hit in the L1 dTLB. And that pretty much
*always* happens, for a very simple reason: the hlist walk will
eventually encounter the final NULL. In fact, since it's used for hash
tables, it usually will encounter it pretty much immediately. In fact,
from what I can tell, at least in that avc_has_perm_noaudit() case,
the NULL case is the *common* case - the hash lists are usually short,
and if it has a single entry (which is common), the *only* prefetch we
do is for that NULL pointer.

I'm not kidding. In hlist_for_each[_entry](), we don't actually
prefetch the first entry ("head->next"), but we *will* prefetch the
NULL ("pos->next").

That's just incredible crap. It's incredible crap that costs us 0.5%
on the simple "make a fully made kernel" benchmark on some of the most
common modern hardware out there. Seriously.

Now, Ingo did some more testing, and on his hardware it looks like
even if you special-case NULL, prefetching at all still just hurts -
because it causes more L1 dcache activity. For a hash chain, if you
actually hit the entry, you do NOT want to prefetch the next entry -
even if it isn't NULL.

So even aside from the fact that apparently "prefetch(NULL)" is a bad
thing on some x86 microarchitectures, it really looks like prefetching
is simply bad - full stop.

So I've got a few choices:

 (a) Just stop using prefetch on x86, because the hardware
implementation of the software prefetch is clearly broken on common
hardware, and the hardware prefetchers do a better job *without* us
messing around. Plus it gets rid of stupid cache pollution.

 (b) make x86 prefetch be conditional and avoid prefetching NULL.  But
see above: it improves things, but not as much as not doing
prefetching at all.

 (c) just stop the insane prefetching in the hlist cases.

and quite frankly, right now I think (c) is the right choice. The fact
is, with a hash table, I think it makes sense maybe trying to prefetch
the first entry, but prefetching all the entries *but* the first one,
and prefetching the NULL? That's just crazy.

I'm not going to do (b). Making a prefetch conditional is stupid. The
conditional isn't going to predict well (think hash chains again -
even if they aren't empty or a single entry, we're talking *short*
chains or you have bigger issues).

And while I could just tell the x86 people to stop generating the
prefetch instruction at all, I do feel that that makes it totally
pointless to ever have software prefetch hints in the kernel source
code, if the major architecture is known to just ignore them because
they are useless.

But before I commit that, I'll give architecture people a heads up.

Now, notice that right now I'm *only* talking about removing it for
the "hlist" cases (patch attached). I suspect we should do the same
thing for all the list helpers.

If some particular code actually knows the list is long and the
prefetch is worth it, maybe we could do it on a case-by-case basis.
But this "do prefetching of the next entry in the hlist loop" just
seems like utter crap.

Comments?

                     Linus

--bcaec52be6e5ed9d7b04a3a41c2b
Content-Type: text/x-patch; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gnvyg1vv0

IGluY2x1ZGUvbGludXgvbGlzdC5oIHwgICAgOSArKysrLS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvbGlzdC5oIGIvaW5jbHVkZS9saW51eC9saXN0LmgKaW5kZXggM2E1NDI2NmExZTg1Li45YWMx
MTE0OGUwMzcgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvbGlzdC5oCisrKyBiL2luY2x1ZGUv
bGludXgvbGlzdC5oCkBAIC02NjQsOCArNjY0LDcgQEAgc3RhdGljIGlubGluZSB2b2lkIGhsaXN0
X21vdmVfbGlzdChzdHJ1Y3QgaGxpc3RfaGVhZCAqb2xkLAogI2RlZmluZSBobGlzdF9lbnRyeShw
dHIsIHR5cGUsIG1lbWJlcikgY29udGFpbmVyX29mKHB0cix0eXBlLG1lbWJlcikKIAogI2RlZmlu
ZSBobGlzdF9mb3JfZWFjaChwb3MsIGhlYWQpIFwKLQlmb3IgKHBvcyA9IChoZWFkKS0+Zmlyc3Q7
IHBvcyAmJiAoeyBwcmVmZXRjaChwb3MtPm5leHQpOyAxOyB9KTsgXAotCSAgICAgcG9zID0gcG9z
LT5uZXh0KQorCWZvciAocG9zID0gKGhlYWQpLT5maXJzdDsgcG9zIDsgcG9zID0gcG9zLT5uZXh0
KQogCiAjZGVmaW5lIGhsaXN0X2Zvcl9lYWNoX3NhZmUocG9zLCBuLCBoZWFkKSBcCiAJZm9yIChw
b3MgPSAoaGVhZCktPmZpcnN0OyBwb3MgJiYgKHsgbiA9IHBvcy0+bmV4dDsgMTsgfSk7IFwKQEAg
LTY4MCw3ICs2NzksNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgaGxpc3RfbW92ZV9saXN0KHN0cnVj
dCBobGlzdF9oZWFkICpvbGQsCiAgKi8KICNkZWZpbmUgaGxpc3RfZm9yX2VhY2hfZW50cnkodHBv
cywgcG9zLCBoZWFkLCBtZW1iZXIpCQkJIFwKIAlmb3IgKHBvcyA9IChoZWFkKS0+Zmlyc3Q7CQkJ
CQkgXAotCSAgICAgcG9zICYmICh7IHByZWZldGNoKHBvcy0+bmV4dCk7IDE7fSkgJiYJCQkgXAor
CSAgICAgcG9zICYmCQkJCQkJCSBcCiAJCSh7IHRwb3MgPSBobGlzdF9lbnRyeShwb3MsIHR5cGVv
ZigqdHBvcyksIG1lbWJlcik7IDE7fSk7IFwKIAkgICAgIHBvcyA9IHBvcy0+bmV4dCkKIApAQCAt
NjkyLDcgKzY5MSw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBobGlzdF9tb3ZlX2xpc3Qoc3RydWN0
IGhsaXN0X2hlYWQgKm9sZCwKICAqLwogI2RlZmluZSBobGlzdF9mb3JfZWFjaF9lbnRyeV9jb250
aW51ZSh0cG9zLCBwb3MsIG1lbWJlcikJCSBcCiAJZm9yIChwb3MgPSAocG9zKS0+bmV4dDsJCQkJ
CQkgXAotCSAgICAgcG9zICYmICh7IHByZWZldGNoKHBvcy0+bmV4dCk7IDE7fSkgJiYJCQkgXAor
CSAgICAgcG9zICYmCQkJCQkJCSBcCiAJCSh7IHRwb3MgPSBobGlzdF9lbnRyeShwb3MsIHR5cGVv
ZigqdHBvcyksIG1lbWJlcik7IDE7fSk7IFwKIAkgICAgIHBvcyA9IHBvcy0+bmV4dCkKIApAQCAt
NzAzLDcgKzcwMiw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBobGlzdF9tb3ZlX2xpc3Qoc3RydWN0
IGhsaXN0X2hlYWQgKm9sZCwKICAqIEBtZW1iZXI6CXRoZSBuYW1lIG9mIHRoZSBobGlzdF9ub2Rl
IHdpdGhpbiB0aGUgc3RydWN0LgogICovCiAjZGVmaW5lIGhsaXN0X2Zvcl9lYWNoX2VudHJ5X2Zy
b20odHBvcywgcG9zLCBtZW1iZXIpCQkJIFwKLQlmb3IgKDsgcG9zICYmICh7IHByZWZldGNoKHBv
cy0+bmV4dCk7IDE7fSkgJiYJCQkgXAorCWZvciAoOyBwb3MgJiYJCQkJCQkJIFwKIAkJKHsgdHBv
cyA9IGhsaXN0X2VudHJ5KHBvcywgdHlwZW9mKCp0cG9zKSwgbWVtYmVyKTsgMTt9KTsgXAogCSAg
ICAgcG9zID0gcG9zLT5uZXh0KQogCg==
--bcaec52be6e5ed9d7b04a3a41c2b--
