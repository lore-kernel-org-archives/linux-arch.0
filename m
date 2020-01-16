From: Sandipan Das <sandipan@linux.ibm.com>
Subject: Re: [PATCH v15 23/23] selftests: vm: pkeys: Use the correct page size
 on powerpc
Date: Thu, 16 Jan 2020 14:03:43 +0530
Message-ID: <375ed2cc-22ea-ddbf-33d3-febed65eefc6@linux.ibm.com>
References: <cover.1576645161.git.sandipan@linux.ibm.com>
 <ff7c288e2a88ccfb3b79be30967646fe5b869683.1576645161.git.sandipan@linux.ibm.com>
 <87h80x9ozr.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <87h80x9ozr.fsf@mpe.ellerman.id.au>
Content-Language: en-US
Sender: owner-linux-mm@kvack.org
To: Michael Ellerman <mpe@ellerman.id.au>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, linux-mm@kvack.org, aneesh.kumar@linux.ibm.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, dave.hansen@intel.com, mingo@redhat.com, msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org, bauerman@linux.ibm.com
List-Id: linux-arch.vger.kernel.org

Hi Michael,

On 15/01/20 12:37 pm, Michael Ellerman wrote:
> Sandipan Das <sandipan@linux.ibm.com> writes:
>> Both 4K and 64K pages are supported on powerpc. Parts of
>> the selftest code perform alignment computations based on
>> the PAGE_SIZE macro which is currently hardcoded to 64K
>> for powerpc. This causes some test failures on kernels
>> configured with 4K page size.
>>
>> This problem is solved by determining the correct page
>> size during the build process rather than hardcoding it
>> in the header file.
> 
> Doing it at build time is wrong, the test could be built on a 4K system
> and then run on a 64K system, or vice versa.
> 
> You should just use getpagesize() at runtime.
> 
> cheers
> 

The reason I chose to do it this way was because PAGE_SIZE also determines
the alignment for the function "lots_o_noops_around_write" (which is used
by some of the test cases). Since __attribute__((__aligned__(X))) requires
X to be a constant, I am not sure if there a way around this.

- Sandipan
