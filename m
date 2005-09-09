Return-Path: <linux-arch-owner@vger.kernel.org>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5B582.08F050A1"
Subject: RE: spinlock-consolidation.patch
Date: Fri, 9 Sep 2005 14:04:17 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F045A8949@scsmsx401.amr.corp.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5B582.08F050A1
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


>Guys, I'm planning on sending this Linuswards in about two days time.=20
>There's never a right time for this sort of thing and there may be some
>relatively trivial breakage for architectures I don't test for.  But it
>kills 1300 lines of code.
>
>So.  Last call, please...

Current ia64 code in Linus' tree includes code in arch/ia64/kernel/mca.c
like this:

#ifdef CONFIG_SMP
        /* read_trylock() would be handy... */
        if (!tasklist_lock.write_lock)
                read_lock(&tasklist_lock);
#endif

which breaks all the SMP ia64 builds with your patch applied.  Keith
Owens has already cleaned up this code to use read_trylock() in my
test tree (and thus in -mm).  But that is part of a much bigger change
that adds a couple of new functions to kernel/sched.c that Keith
only posted to LKML yesterday (http://tinyurl.com/8urfm), since Zwane
has already posed a question about this change it seems unlikely that
this will be resolved before the cut-off for big merges.

So you need to add the attached patch to yours before sending to Linus.

-Tony

------_=_NextPart_001_01C5B582.08F050A1
Content-Type: application/octet-stream;
	name="ia64-fix-spinlock.patch"
Content-Transfer-Encoding: base64
Content-Description: ia64-fix-spinlock.patch
Content-Disposition: attachment;
	filename="ia64-fix-spinlock.patch"

W0lBNjRdIENsZWFuLXVwIGRpcmVjdCBhY2Nlc3MgdG8gdGFza2xpc3RfbG9jay53cml0ZV9sb2Nr
CgpTaWduZWQtb2ZmLWJ5OiBUb255IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+CgpkaWZmIC1y
dSBsaW51eC9hcmNoL2lhNjQva2VybmVsL21jYS5jIHRpZ2VyLXNtcC9hcmNoL2lhNjQva2VybmVs
L21jYS5jCi0tLSBsaW51eC9hcmNoL2lhNjQva2VybmVsL21jYS5jCTIwMDUtMDktMDkgMTM6MTM6
MTIuMDAwMDAwMDAwIC0wNzAwCisrKyB0aWdlci1zbXAvYXJjaC9pYTY0L2tlcm5lbC9tY2EuYwky
MDA1LTA5LTA5IDEzOjQ5OjQ3LjAwMDAwMDAwMCAtMDcwMApAQCAtNDkxLDEyICs0OTEsNyBAQAog
CXVud19pbml0X2Zyb21faW50ZXJydXB0aW9uKCZpbmZvLCBjdXJyZW50LCBwdCwgc3cpOwogCWlh
NjRfZG9fc2hvd19zdGFjaygmaW5mbywgTlVMTCk7CiAKLSNpZmRlZiBDT05GSUdfU01QCi0JLyog
cmVhZF90cnlsb2NrKCkgd291bGQgYmUgaGFuZHkuLi4gKi8KLQlpZiAoIXRhc2tsaXN0X2xvY2su
d3JpdGVfbG9jaykKLQkJcmVhZF9sb2NrKCZ0YXNrbGlzdF9sb2NrKTsKLSNlbmRpZgotCXsKKwlp
ZiAocmVhZF90cnlsb2NrKCZ0YXNrbGlzdF9sb2NrKSkgewogCQlzdHJ1Y3QgdGFza19zdHJ1Y3Qg
KmcsICp0OwogCQlkb19lYWNoX3RocmVhZCAoZywgdCkgewogCQkJaWYgKHQgPT0gY3VycmVudCkK
QEAgLTUwNiwxMCArNTAxLDYgQEAKIAkJCXNob3dfc3RhY2sodCwgTlVMTCk7CiAJCX0gd2hpbGVf
ZWFjaF90aHJlYWQgKGcsIHQpOwogCX0KLSNpZmRlZiBDT05GSUdfU01QCi0JaWYgKCF0YXNrbGlz
dF9sb2NrLndyaXRlX2xvY2spCi0JCXJlYWRfdW5sb2NrKCZ0YXNrbGlzdF9sb2NrKTsKLSNlbmRp
ZgogCiAJcHJpbnRrKCJcbklOSVQgZHVtcCBjb21wbGV0ZS4gIFBsZWFzZSByZWJvb3Qgbm93Llxu
Iik7CiAJd2hpbGUgKDEpOwkJCS8qIGhhbmcgY2l0eSBpZiBubyBkZWJ1Z2dlciAqLwo=

------_=_NextPart_001_01C5B582.08F050A1--
