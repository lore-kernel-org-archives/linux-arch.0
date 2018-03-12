From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] x86, powerpc : pkey-mprotect must allow pkey-0
Date: Mon, 12 Mar 2018 08:46:04 -0700
Message-ID: <96b08909-906b-86b6-f4ee-67b9f8eff5d7@intel.com>
References: <1520583161-11741-1-git-send-email-linuxram@us.ibm.com>
 <87lgf1v9di.fsf@concordia.ellerman.id.au>
 <20180309200631.GS1060@ram.oc3035372033.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180309200631.GS1060@ram.oc3035372033.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ram Pai <linuxram@us.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: mingo@redhat.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net, arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com, Ulrich.Weigand@de.ibm.com
List-Id: linux-arch.vger.kernel.org

On 03/09/2018 12:06 PM, Ram Pai wrote:
> On Fri, Mar 09, 2018 at 09:19:53PM +1100, Michael Ellerman wrote:
>> Ram Pai <linuxram@us.ibm.com> writes:
>>
>>> Once an address range is associated with an allocated pkey, it cannot be
>>> reverted back to key-0. There is no valid reason for the above behavior.  On
>>> the contrary applications need the ability to do so.
>> Please explain this in much more detail. Is it an ABI change?
> Not necessarily an ABI change. older binary applications  will continue
> to work. It can be considered as a bug-fix.

Yeah, agreed.  I do not think this is an ABI change.
