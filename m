From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v16 00/23] selftests, powerpc, x86: Memory Protection Keys
Date: Mon, 27 Jan 2020 07:42:33 -0800
Message-ID: <3eca7a91-aa3e-cb01-47c8-5d36020993a2@intel.com>
References: <cover.1579507768.git.sandipan@linux.ibm.com>
 <3ceb2814-f8b0-ec6b-3c24-ec72297a99f5@intel.com>
 <8f14bee0-ab1c-fc90-dfdb-5128607b767f@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
In-Reply-To: <8f14bee0-ab1c-fc90-dfdb-5128607b767f@linux.ibm.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
To: Sandipan Das <sandipan@linux.ibm.com>
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, aneesh.kumar@linux.ibm.com, x86@kernel.org, linuxram@us.ibm.com, linuxppc-dev@lists.ozlabs.org, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, linux-kselftest@vger.kernel.org, msuchanek@suse.de, shuah@kernel.org, bauerman@linux.ibm.com
List-Id: linux-arch.vger.kernel.org

On 1/27/20 2:11 AM, Sandipan Das wrote:
> Hi Dave,
> 
> On 23/01/20 12:15 am, Dave Hansen wrote:
>> Still doesn't build for me:
>>
> I have this patch that hopefully fixes this. My understanding was
> that the vm tests are supposed to be generic but this has quite a
> bit of x86-specific conditional code which complicates things even
> though it is not used by any of the other tests.
> 
> I'm not sure if we should keep x86 multilib build support for these
> selftests but I'll let the maintainers take a call.

How have you tested this patch (and the whole series for that matter)?
