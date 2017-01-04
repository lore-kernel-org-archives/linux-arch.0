From: Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [RFC PATCH v3] sparc64: Add support for Application Data
 Integrity (ADI)
Date: Wed, 4 Jan 2017 15:40:23 -0800
Message-ID: <d234fb8b-965f-d966-46fe-965478fdf7cb@linux.intel.com>
References: <1483569999-13543-1-git-send-email-khalid.aziz@oracle.com>
 <6fcaab9f-40fb-fdfb-2c7e-bf21a862ab7c@linux.intel.com>
 <ae0b7d0b-54fa-fa93-3b50-d14ace1b16f5@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <ae0b7d0b-54fa-fa93-3b50-d14ace1b16f5@oracle.com>
Sender: owner-linux-mm@kvack.org
To: Rob Gardner <rob.gardner@oracle.com>, Khalid Aziz <khalid.aziz@oracle.com>, davem@davemloft.net, corbet@lwn.net, arnd@arndb.de, akpm@linux-foundation.org
Cc: hpa@zytor.com, viro@zeniv.linux.org.uk, nitin.m.gupta@oracle.com, chris.hyser@oracle.com, tushar.n.dave@oracle.com, sowmini.varadhan@oracle.com, mike.kravetz@oracle.com, adam.buchbinder@gmail.com, minchan@kernel.org, hughd@google.com, kirill.shutemov@linux.intel.com, keescook@chromium.org, allen.pais@oracle.com, aryabinin@virtuozzo.com, atish.patra@oracle.com, joe@perches.com, pmladek@suse.com, jslaby@suse.cz, cmetcalf@mellanox.com, paul.gortmaker@windriver.com, mhocko@suse.com, jmarchan@redhat.com, lstoakes@gmail.com, 0x7f454c46@gmail.com, vbabka@suse.cz, tglx@linutronix.de, mingo@redhat.com, dan.j.williams@intel.com, iamjoonsoo.kim@lge.com, mgorman@techsingularity.net, vdavydov.dev@gmail.com, hannes@cmpxchg.org, namit@vmware.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-mm@kva
List-Id: linux-arch.vger.kernel.org

On 01/04/2017 03:35 PM, Rob Gardner wrote:
> Tags are not cleared at all when memory is freed, but rather, lazily
> (and automatically) cleared when memory is allocated.

What does "allocated" mean in this context?  Physical or virtual? What
does this do, for instance?

	ptr = malloc(PAGE_SIZE);
	set_tag(ptr, 14);
	madvise(ptr, PAGE_SIZE, MADV_FREE);
	printf("tag: %d\n", get_tag(ptr));
	free(ptr);

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
