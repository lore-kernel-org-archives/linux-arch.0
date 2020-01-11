From: Sandipan Das <sandipan@linux.ibm.com>
Subject: Re: [PATCH v15 00/24] selftests, powerpc, x86: Memory Protection Keys
Date: Sat, 11 Jan 2020 22:20:34 +0530
Message-ID: <3a6280fe-6b0f-7e3c-08a9-8186a9c3ea46@linux.ibm.com>
References: <cover.1576645161.git.sandipan@linux.ibm.com>
 <87y2ufxlci.fsf@linux.ibm.com>
 <4a35bf48-d191-4e42-ea47-f419895ed876@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <4a35bf48-d191-4e42-ea47-f419895ed876@intel.com>
Content-Language: en-US
Sender: owner-linux-mm@kvack.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org, fweimer@redhat.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, bauerman@linux.ibm.com, msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
List-Id: linux-arch.vger.kernel.org

Hi Dave,

On 10/01/20 11:27 pm, Dave Hansen wrote:
> 
> Could you dump these in a git tree, please?  It will make it a wee bit
> easier for me to ship the resulting tree around to a couple different
> systems.
> 

I have pushed a version of this series that uses u64 for all references
to the pkey register irrespective of architecture. This is available at:

https://github.com/sandip4n/linux/tree/pkey-selftests


- Sandipan
