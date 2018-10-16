From: valdis.kletnieks@vt.edu
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
Date: Mon, 15 Oct 2018 20:33:51 -0400
Message-ID: <5192.1539650031@turing-police.cc.vt.edu>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <87va62lri4.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1539650031_2195P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87va62lri4.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Enke Chen <enkechen@cisco.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <rie>
List-Id: linux-arch.vger.kernel.org

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
