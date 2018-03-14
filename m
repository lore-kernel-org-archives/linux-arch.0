From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 1/1 v2] x86: pkey-mprotect must allow pkey-0
Date: Wed, 14 Mar 2018 10:51:26 -0700
Message-ID: <5027ca9e-63c8-47ab-960d-a9c4466d7075@intel.com>
References: <1521013574-27041-1-git-send-email-linuxram@us.ibm.com>
 <18b155e3-07e9-5a4b-1f95-e1667078438c@intel.com>
 <20180314171448.GA1060@ram.oc3035372033.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314171448.GA1060@ram.oc3035372033.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ram Pai <linuxram@us.ibm.com>
Cc: mingo@redhat.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net, arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com
List-Id: linux-arch.vger.kernel.org

On 03/14/2018 10:14 AM, Ram Pai wrote:
> I look at key-0 as 'the key'. It has special status. 
> (a) It always exist.

Do you mean "is always allocated"?

> (b) it cannot be freed.

This is the one I'm questioning.

> (c) it is assigned by default.

I agree on this totally. :)

> (d) its permissions cannot be modified.

Why not?  You could pretty easily get a thread going that had its stack
covered with another pkey and that was being very careful what it
accesses.  It could pretty easily set pkey-0's access or write-disable bits.

> (e) it bypasses key-permission checks when assigned.

I don't think this is necessary.  I think the only rule we *need* is:

	pkey-0 is allocated implicitly at execve() time.  You do not
	need to call pkey_alloc() to allocate it.

> An arch need not necessarily map 'the key-0' to its key-0.  It could
> internally map it to any of its internal key of its choice, transparent
> to the application.

I don't understand what you are saying here.
