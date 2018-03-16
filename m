From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 13/22] signal: Move addr_lsb into the _sigfault union for
 clarity
Date: Fri, 16 Mar 2018 12:00:16 -0700
Message-ID: <29eb3438-0891-36ee-e5f6-36e26ccf2b89@intel.com>
References: <87k1wimybi.fsf_-_@xmission.com>
 <20180116004009.31036-13-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180116004009.31036-13-ebiederm@xmission.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 01/15/2018 04:40 PM, Eric W. Biederman wrote:
> The addr_lsb fields is only valid and available when the
> signal is SIGBUS and the si_code is BUS_MCEERR_AR or BUS_MCEERR_AO.
> Document this with a comment and place the field in the _sigfault union
> to make this clear.
> 
> All of the fields stay in the same physical location so both the old
> and new definitions of struct siginfo will continue to work.

This breaks the ABI and breaks protection keys.  The physical locations
*DO* change.

Before this patch:

#define si_pkey         _sifields._sigfault._pkey
(gdb) print &((siginfo_t *)0)->_sifields._sigfault._pkey
$1 = (__u32 *) 0x20 <irq_stack_union+32>

and after:

+#define si_pkey                _sifields._sigfault._addr_pkey._pkey
(gdb) print &((siginfo_t *)0)->_sifields._sigfault._addr_pkey._pkey
$1 = (__u32 *) 0x1c

Can we revert this, please?
