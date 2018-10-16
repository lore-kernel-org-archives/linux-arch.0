Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outbound.smtp.vt.edu ([198.82.183.121]:50940 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726946AbeJPIVm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Oct 2018 04:21:42 -0400
Received: from mr1.cc.vt.edu (inbound.smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w9G0Y0o3008783
        for <linux-arch@vger.kernel.org>; Mon, 15 Oct 2018 20:34:00 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w9G0Xts2009532
        for <linux-arch@vger.kernel.org>; Mon, 15 Oct 2018 20:34:00 -0400
Received: by mail-qt1-f200.google.com with SMTP id y23-v6so22601276qtc.7
        for <linux-arch@vger.kernel.org>; Mon, 15 Oct 2018 17:34:00 -0700 (PDT)
From: valdis.kletnieks@vt.edu
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
In-Reply-To: <87va62lri4.fsf@xmission.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <87va62lri4.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1539650031_2195P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 15 Oct 2018 20:33:51 -0400
Message-ID: <5192.1539650031@turing-police.cc.vt.edu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Enke Chen <enkechen@cisco.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Roman Gushchin <guro@fb.com>, Marcos Paulo de Souza <marcos.souza.org@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Cyrill Gorcunov <gorcunov@openvz.org>, Yang Shi <yang.shi@linux.alibaba.com>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Victor Kamensky (kamensky)" <kamensky@cisco.com>, xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>
Message-ID: <20181016003351.omD9PIsQjB0zJH1FsDGlCQGhezbz-70prTl8X68vleA@z>

--==_Exmh_1539650031_2195P
Content-Type: text/plain; charset=us-ascii

On Mon, 15 Oct 2018 18:28:03 -0500, Eric W. Biederman said:
> Enke Chen <enkechen@cisco.com> writes:
>
> > For simplicity and consistency, this patch provides an implementation
> > for signal-based fault notification prior to the coredump of a child
> > process. A new prctl command, PR_SET_PREDUMP_SIG, is defined that can
> > be used by an application to express its interest and to specify the
> > signal (SIGCHLD or SIGUSR1 or SIGUSR2) for such a notification. A new
> > signal code (si_code), CLD_PREDUMP, is also defined for SIGCHLD.
> >
> > Background:
> >
> > As the coredump of a process may take time, in certain time-sensitive
> > applications it is necessary for a parent process (e.g., a process
> > manager) to be notified of a child's imminent death before the coredump
> > so that the parent process can act sooner, such as re-spawning an
> > application process, or initiating a control-plane fail-over.
>
> You talk about time senstive and then you talk about bash scripts.
> I don't think your definition of time-sensitive and my definition match.

When the process image is measured in hundreds of gigabytes, the corefile can
take a while even by /bin/bash standards.  You want fun, watch an HPC process
manage to OOM a machine with 3T of RAM in a way that produces a full image
coredump.

To network storage.


--==_Exmh_1539650031_2195P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBW8Ux740DS38y7CIcAQJpSAf8CFlhML3n1ezv9Www7szL9y4zQSSV/ELG
HvVFpEvQrLIU8cc3TvFIN0zBVIfdyNUwU01fmUT2CasrmdNQiDfZg88e6dUFdNgH
Sm5MRVZJqlfBH8NycbmVs4RclMlbyNgYz9Dk9vAnw2FqBehjoQPvVmAhGr4KiFpP
oF9xSDEMm2URShb/g0PCaB64dOHPObqnRaNtdYYrTeIw6fKSC8ravOiLzRp9u2uA
JrQZE0WwKM0aE5EQNur0DucH7VJ5tpBxdTqDWkTtivHt81Z+SZ/w6/yliScupxt3
4ByNw0CeSreIV4VLyJuZyZkUi3I+s2nXn+JuOjrZxu2AL/eurFwG5A==
=p90O
-----END PGP SIGNATURE-----

--==_Exmh_1539650031_2195P--
