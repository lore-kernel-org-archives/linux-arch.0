From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Date: Mon, 03 Aug 2020 08:42:50 -0700
Message-ID: <1596469370.29091.13.camel@HansenPartnership.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
         <20200730152250.GG23808@casper.infradead.org>
         <db3bdbae-eb0f-1ae3-94dd-045e37bc94ba@oracle.com>
         <20200730171251.GI23808@casper.infradead.org>
         <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
         <20200730174956.GK23808@casper.infradead.org>
         <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
         <87y2n03brx.fsf@x220.int.ebiederm.org>
         <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com>
         <877dufvje9.fsf@x220.int.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <877dufvje9.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>, Steven Sistare <steven.sistare@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, Anthony Yznaga <anthony.yznaga@oracle.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org, ktkhai@virtuozzo.com, christian.brauner@ubuntu.com, peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me, areber@redhat.com, cyphar@cyphar.com
List-Id: linux-arch.vger.kernel.org

On Mon, 2020-08-03 at 10:28 -0500, Eric W. Biederman wrote:
[...]
> What is wrong with live migration between one qemu process and
> another qemu process on the same machine not work for this use case?
> 
> Just reusing live migration would seem to be the simplest path of
> all, as the code is already implemented.  Further if something goes
> wrong with the live migration you can fallback to the existing
> process.  With exec there is no fallback if the new version does not
> properly support the handoff protocol of the old version.

Actually, could I ask this another way: the other patch set you sent to
the KVM list was to snapshot the VM to a PKRAM capsule preserved across
kexec using zero copy for extremely fast save/restore.  The original
idea was to use this as part of a CRIU based snapshot, kexec to new
system, restore.  However, why can't you do a local snapshot, restart
qemu, restore using the PKRAM capsule to achieve exactly the same as
MADV_DOEXEC does but using a system that's easy to reason about?  It
may be slightly slower, but I think we're still talking milliseconds.

James
