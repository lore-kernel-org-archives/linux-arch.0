From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from asm
Date: Tue, 29 Nov 2016 09:10:58 -0800
Message-ID: <CA+55aFxCKgTrh1gS-cMyhBa0QoLW2DL2+DYxOAcA-Bd15H15vg@mail.gmail.com>
References: <20161129131922.GA31466@angband.pl> <20161129135118.24696-1-kilobyte@angband.pl>
 <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com> <20161129170522.GA3441@angband.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113ee5e412c2da054273ac90
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34140 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754531AbcK2RLF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Nov 2016 12:11:05 -0500
In-Reply-To: <20161129170522.GA3441@angband.pl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adam Borowski <kilobyte@angband.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Ben Hutchings <ben@decadent.org.uk>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

--001a113ee5e412c2da054273ac90
Content-Type: text/plain; charset=UTF-8

On Tue, Nov 29, 2016 at 9:05 AM, Adam Borowski <kilobyte@angband.pl> wrote:
>
> Thus, if it's indeed binutils, you'll see the breakage as soon as Fedora
> recovers from the freeze.

So quite frankly, I don't want to make our kernel sources worse due to
broken shit tools getting something wrong that we shouldn't even care
about.

How about this stupid patch? It weakens modversions, but that may be
ok for Debian, and a better alternative than just saying "we don't
support it at all".

            Linus

--001a113ee5e412c2da054273ac90
Content-Type: text/plain; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iw3rettv0

IGtlcm5lbC9tb2R1bGUuYyB8IDUgKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEva2VybmVsL21vZHVsZS5jIGIva2VybmVs
L21vZHVsZS5jCmluZGV4IGY1N2RkNjMxODZlNi4uMGU1NGQ1YmYwMDk3IDEwMDY0NAotLS0gYS9r
ZXJuZWwvbW9kdWxlLmMKKysrIGIva2VybmVsL21vZHVsZS5jCkBAIC0xMzAxLDggKzEzMDEsOSBA
QCBzdGF0aWMgaW50IGNoZWNrX3ZlcnNpb24oRWxmX1NoZHIgKnNlY2hkcnMsCiAJCWdvdG8gYmFk
X3ZlcnNpb247CiAJfQogCi0JcHJfd2FybigiJXM6IG5vIHN5bWJvbCB2ZXJzaW9uIGZvciAlc1xu
IiwgbW9kLT5uYW1lLCBzeW1uYW1lKTsKLQlyZXR1cm4gMDsKKwkvKiBCcm9rZW4gdG9vbGNoYWlu
LiBXYXJuIG9uY2UsIHRoZW4gbGV0IGl0IGdvLi4gKi8KKwlwcl93YXJuX29uY2UoIiVzOiBubyBz
eW1ib2wgdmVyc2lvbiBmb3IgJXNcbiIsIG1vZC0+bmFtZSwgc3ltbmFtZSk7CisJcmV0dXJuIDE7
CiAKIGJhZF92ZXJzaW9uOgogCXByX3dhcm4oIiVzOiBkaXNhZ3JlZXMgYWJvdXQgdmVyc2lvbiBv
ZiBzeW1ib2wgJXNcbiIsCg==
--001a113ee5e412c2da054273ac90--
