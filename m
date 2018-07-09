Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:51671 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754544AbeGIX56 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2018 19:57:58 -0400
Received: by mail-it0-f41.google.com with SMTP id g4-v6so11904672iti.1
        for <linux-arch@vger.kernel.org>; Mon, 09 Jul 2018 16:57:58 -0700 (PDT)
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Jul 2018 16:57:46 -0700
Message-ID: <CA+55aFxWZuFNHKpE0iA+vDJHTyPofSX3BPPOt2UUB2zXSSBZHQ@mail.gmail.com>
Subject: Can people please check this patch out for cross-arch issues
Content-Type: multipart/mixed; boundary="000000000000647e5a057099c8f4"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch <linux-arch@vger.kernel.org>

--000000000000647e5a057099c8f4
Content-Type: text/plain; charset="UTF-8"

We have a funny new bugzilla entry for an issue that is 12 years old,
and not really all that critical, but one that *can* become a problem
for people who do very specific things.

What happens is that 'fork()' will cause a re-try (with
ERESTARTNOINTR) if a signal has come in between the point where the
fork() started, but before we add the process to the process table.
The reason is that the signal possibly *should* affect the new child
process too, but it was never queued to it because we were obviously
in the process of creating it.

That's normally entirely a non-issue, and I don't think anybody ever
imagined it could matter in practice, but apparently there are loads
where this becomes problematic.

See kernel bugzilla at

    https://bugzilla.kernel.org/show_bug.cgi?id=200447

which has a trial balloon patch for this issue already, to at least
limit that retry to only signals that actually might affect the child
(ie not any random signals sent explicitly and directly only to the
parent process).

HOWEVER.

The very first thing I noticed while looking at this was that one of
the more expensive parts of the fork() retry is actually marking all
the parent page tables read-only. Now, it's one of _many_ expensive
parts, and it's not nearly as expensive as all the reference counting
we do for each page, but it's actually very easy to avoid. When we
have repeated fork() calls, there's just no point in repeatedly
marking pages read-only.

This the attached one-liner patch.

The reason I'm sending it to the arch people is that while this is a
totally trivial patch on x86 ("pte_write()" literally tests exactly
the same bit that "pte_wrprotect()" and "ptep_set_wrprotect()"
clears), the same is not necessarily always true on other
architectures.

Some other architectures make "ptep_set_wrprotect()" do more than just
clear the one bit we test with "pte_write()".

Honestly, I don't think it could possibly matter: if "pte_write()"
returns false, then whatever "ptep_set_writeprotect()" does can not
really matter (at least for a COW mapping). But I thought I'd send
this out for comments anyway, despite how trivial it looks.

So. Comments?

It doesn't make a huge difference, honestly, and the real fix for the
"retry too eagerly" is completely different, but at the same time this
one-liner trivial fix does feel like the RightThing(tm) regardless.

                 Linus

--000000000000647e5a057099c8f4
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-mm-cow-don-t-bother-write-protecting-already-write-p.patch"
Content-Disposition: attachment;
	filename="0001-mm-cow-don-t-bother-write-protecting-already-write-p.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jjex755m0>
X-Attachment-Id: f_jjex755m0

RnJvbSA5YzFiMjhjNzNjYWMyOTkyNTUxMWI2YjVjZjc2ZTdmNjg2MDg1OGY4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IE1vbiwgOSBKdWwgMjAxOCAxMzoxOTo0OSAtMDcwMApTdWJqZWN0OiBb
UEFUQ0hdIG1tL2NvdzogZG9uJ3QgYm90aGVyIHdyaXRlIHByb3RlY3RpbmcgYWxyZWFkeSB3cml0
ZS1wcm90ZWN0ZWQKIHBhZ2VzCgpUaGlzIGlzIG5vdCBub3JtYWxseSBub3RpY2VhYmxlLCBidXQg
cmVwZWF0ZWQgZm9ya3MgKGVpdGhlciBiZWNhdXNlIHRoZQpwcm9jZXNzIGl0c2VsZiB1c2VzIGZv
cmsoKSBhIGxvdCwgb3IgYmVjYXVzZSBvZiB0aGUga2VybmVsIHJldHJ5IGR1ZSB0bwpzaWduYWwg
aGFuZGxpbmcpIGFyZSB1bm5lY2Vzc2FyaWx5IGV4cGVuc2l2ZSBiZWNhdXNlIHRoZXkgcmVwZWF0
ZWRseQpkaXJ0eSB0aGUgcGFyZW50IHBhZ2UgdGFibGVzIGR1cmluZyB0aGUgcGFnZSB0YWJsZSBj
b3B5IG9wZXJhdGlvbi4KCkl0J3MgdHJpdmlhbCB0byBqdXN0IGF2b2lkIHdyaXRlIHByb3RlY3Rp
bmcgdGhlIHBhZ2UgdGFibGUgZW50cnkgaWYgaXQKd2FzIGFscmVhZHkgbm90IHdyaXRhYmxlLgoK
VGhpcyBwYXRjaCB3YXMgaW5zcGlyZWQgYnkKCiAgICBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5v
cmcvc2hvd19idWcuY2dpP2lkPTIwMDQ0NwoKd2hpY2ggcG9pbnRzIHRvIGFuIGFuY2llbnQgIndh
c3RlIHRpbWUgcmUtZG9pbmcgZm9yayIgaXNzdWUgaW4gdGhlCnByZXNlbmNlIG9mIGxvdHMgb2Yg
c2lnbmFscy4gIEl0IGRvZXNuJ3QgX2ZpeF8gdGhlIGlzc3VlLCBidXQgaXQgYXZvaWRzCmF0IGxl
YXN0IHBhcnQgb2YgdGhlIHVubmVjZXNzYXJ5IG92ZXJoZWFkIHdoZW4geW91IGRvIGVuZCB1cCBy
ZXBlYXRpbmcgYQpmb3JrKCkuCgpDYzogRXJpYyBCaWVkZXJtYW4gPGViaWVkZXJtQHhtaXNzaW9u
LmNvbT4KQ2M6IE9sZWcgTmVzdGVyb3YgPG9sZWdAcmVkaGF0LmNvbT4KQ2M6IEFuZHJldyBNb3J0
b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+ClNpZ25lZC1vZmYtYnk6IExpbnVzIFRvcnZh
bGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0tCiBtbS9tZW1vcnkuYyB8IDIg
Ky0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL21tL21lbW9yeS5jIGIvbW0vbWVtb3J5LmMKaW5kZXggNzIwNmE2MzQyNzBiLi41N2U2
MWQ1MDUzNWYgMTAwNjQ0Ci0tLSBhL21tL21lbW9yeS5jCisrKyBiL21tL21lbW9yeS5jCkBAIC0x
MDE3LDcgKzEwMTcsNyBAQCBjb3B5X29uZV9wdGUoc3RydWN0IG1tX3N0cnVjdCAqZHN0X21tLCBz
dHJ1Y3QgbW1fc3RydWN0ICpzcmNfbW0sCiAJICogSWYgaXQncyBhIENPVyBtYXBwaW5nLCB3cml0
ZSBwcm90ZWN0IGl0IGJvdGgKIAkgKiBpbiB0aGUgcGFyZW50IGFuZCB0aGUgY2hpbGQKIAkgKi8K
LQlpZiAoaXNfY293X21hcHBpbmcodm1fZmxhZ3MpKSB7CisJaWYgKGlzX2Nvd19tYXBwaW5nKHZt
X2ZsYWdzKSAmJiBwdGVfd3JpdGUocHRlKSkgewogCQlwdGVwX3NldF93cnByb3RlY3Qoc3JjX21t
LCBhZGRyLCBzcmNfcHRlKTsKIAkJcHRlID0gcHRlX3dycHJvdGVjdChwdGUpOwogCX0KLS0gCjIu
MTguMC4xMzIuZzk1ZWRhM2Q4NgoK
--000000000000647e5a057099c8f4--
