Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44322 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbeI2Xyf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Sep 2018 19:54:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so6357772pff.11
        for <linux-arch@vger.kernel.org>; Sat, 29 Sep 2018 10:25:21 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/3] namei: implement AT_THIS_ROOT chroot-like path resolution
From: Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <CAG48ez30WJhbsro2HOc_DR7V91M+hNFzBP5ogRMZaxbAORvqzg@mail.gmail.com>
Date: Sat, 29 Sep 2018 10:25:17 -0700
Content-Transfer-Encoding: quoted-printable
Message-ID: <F0E08B90-F10B-4897-913D-CA18E99A987D@amacapital.net>
References: <20180929103453.12025-1-cyphar@cyphar.com> <20180929131534.24472-1-cyphar@cyphar.com> <CAG48ez30WJhbsro2HOc_DR7V91M+hNFzBP5ogRMZaxbAORvqzg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jann Horn <jannh@google.com>
Cc: cyphar@cyphar.com, "Eric W. Biederman" <ebiederm@xmission.com>, jlayton@kernel.org, Bruce Fields <bfields@fieldses.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, shuah@kernel.org, David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>, christian@brauner.io, Tycho Andersen <tycho@tycho.ws>, kernel list <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, linux-kselftest@vger.kernel.org, dev@opencontainers.org, containers@lists.linux-foundation.org, Linux API <linux-api@vger.kernel.org>
Message-ID: <20180929172517.24HCvb-E7bGl_kfSWVJW2T4dgh1oyPfN3FrqSGEbR4U@z>



> On Sep 29, 2018, at 9:35 AM, Jann Horn <jannh@google.com> wrote:
>=20
> +cc linux-api; please keep them in CC for future versions of the patch
>=20
>> On Sat, Sep 29, 2018 at 4:29 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>> The primary motivation for the need for this flag is container runtimes
>> which have to interact with malicious root filesystems in the host
>> namespaces. One of the first requirements for a container runtime to be
>> secure against a malicious rootfs is that they correctly scope symlinks
>> (that is, they should be scoped as though they are chroot(2)ed into the
>> container's rootfs) and ".."-style paths. The already-existing AT_XDEV
>> and AT_NO_PROCLINKS help defend against other potential attacks in a
>> malicious rootfs scenario.
>=20
> So, I really like the concept for patch 1 of this series (but haven't
> read the code yet); but I dislike this patch because of its footgun
> potential.
>=20

The code could do it differently: do the path walk and then, before acceptin=
g the result, walk back up and make sure the result is under the starting po=
int.

This is *not* a full solution, though, since a walk above the root gas side e=
ffects on timing, various caches, and possibly network traffic, so it=E2=80=99=
s open to Spectre-like attacks in which a malicious container could use a ru=
ntime-initiated AT_THIS_ROOT to infer the existence of directories outside t=
he container.

But what=E2=80=99s the container usecase?  Any sane container is based on pi=
vot_root or similar, so the runtime can just do the walk in the container co=
ntext. IOW I=E2=80=99m a bit confused as to the exact intended use of the wh=
ole series. Can you elaborate?=
