From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v15 00/24] selftests, powerpc, x86: Memory Protection Keys
Date: Fri, 10 Jan 2020 23:08:53 +0530
Message-ID: <87y2ufxlci.fsf@linux.ibm.com>
References: <cover.1576645161.git.sandipan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <cover.1576645161.git.sandipan@linux.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Sandipan Das <sandipan@linux.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, linux-mm@kvack.org, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, dave.hansen@intel.com, mingo@redhat.com, msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org, bauerman@linux.ibm.com
List-Id: linux-arch.vger.kernel.org

Sandipan Das <sandipan@linux.ibm.com> writes:

> Memory protection keys enables an application to protect its address
> space from inadvertent access by its own code.
>
> This feature is now enabled on powerpc and has been available since
> 4.16-rc1. The patches move the selftests to arch neutral directory
> and enhance their test coverage.
>
> Testing
> -------
> Verified for correctness on powerpc. Need help with x86 testing as I
> do not have access to a Skylake server. Client platforms like Coffee
> Lake do not have the required feature bits set in CPUID.
>
> Changelog
> ---------
> Link to previous version (v14):
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=55981&state=*
>
> v15:
> 	(1) Rebased on top of latest master.
> 	(2) Addressed review comments from Dave Hansen.
> 	(3) Moved code for getting or setting pkey bits to new
> 	    helpers. These changes replace patch 7 of v14.
> 	(4) Added a fix which ensures that the correct count of
> 	    reserved keys is used across different platforms.
> 	(5) Added a fix which ensures that the correct page size
> 	    is used as powerpc supports both 4K and 64K pages.
>

Any update on merging this series? Can Intel help with testing this
series on Skylake server? Possibly merging to -next will result in
automated 01.org tests?


> v14:
> 	(1) Incorporated another round of comments from Dave Hansen.
>
> v13:
> 	(1) Incorporated comments for Dave Hansen.
> 	(2) Added one more test for correct pkey-0 behavior.
>
> v12:
> 	(1) Fixed the offset of pkey field in the siginfo structure for
> 	    x86_64 and powerpc. And tries to use the actual field
> 	    if the headers have it defined.
>
> v11:
> 	(1) Fixed a deadlock in the ptrace testcase.
>
> v10 and prior:
> 	(1) Moved the testcase to arch neutral directory.
> 	(2) Split the changes into incremental patches.
>
> Desnes A. Nunes do Rosario (1):
>   selftests/vm/pkeys: Fix number of reserved powerpc pkeys
>
> Ram Pai (17):
>   selftests/x86/pkeys: Move selftests to arch-neutral directory
>   selftests/vm/pkeys: Rename all references to pkru to a generic name
>   selftests/vm/pkeys: Move generic definitions to header file
>   selftests/vm/pkeys: Typecast the pkey register
>   selftests/vm/pkeys: Fix pkey_disable_clear()
>   selftests/vm/pkeys: Fix assertion in pkey_disable_set/clear()
>   selftests/vm/pkeys: Fix alloc_random_pkey() to make it really random
>   selftests/vm/pkeys: Introduce generic pkey abstractions
>   selftests/vm/pkeys: Introduce powerpc support
>   selftests/vm/pkeys: Fix assertion in test_pkey_alloc_exhaust()
>   selftests/vm/pkeys: Improve checks to determine pkey support
>   selftests/vm/pkeys: Associate key on a mapped page and detect access
>     violation
>   selftests/vm/pkeys: Associate key on a mapped page and detect write
>     violation
>   selftests/vm/pkeys: Detect write violation on a mapped
>     access-denied-key page
>   selftests/vm/pkeys: Introduce a sub-page allocator
>   selftests/vm/pkeys: Test correct behaviour of pkey-0
>   selftests/vm/pkeys: Override access right definitions on powerpc
>
> Sandipan Das (3):
>   selftests: vm: pkeys: Add helpers for pkey bits
>   selftests: vm: pkeys: Use the correct huge page size
>   selftests: vm: pkeys: Use the correct page size on powerpc
>
> Thiago Jung Bauermann (2):
>   selftests/vm/pkeys: Move some definitions to arch-specific header
>   selftests/vm/pkeys: Make gcc check arguments of sigsafe_printf()
>
>  tools/testing/selftests/vm/.gitignore         |   1 +
>  tools/testing/selftests/vm/Makefile           |   5 +
>  tools/testing/selftests/vm/pkey-helpers.h     | 226 ++++++
>  tools/testing/selftests/vm/pkey-powerpc.h     | 138 ++++
>  tools/testing/selftests/vm/pkey-x86.h         | 183 +++++
>  .../selftests/{x86 => vm}/protection_keys.c   | 688 ++++++++++--------
>  tools/testing/selftests/x86/.gitignore        |   1 -
>  tools/testing/selftests/x86/pkey-helpers.h    | 219 ------
>  8 files changed, 931 insertions(+), 530 deletions(-)
>  create mode 100644 tools/testing/selftests/vm/pkey-helpers.h
>  create mode 100644 tools/testing/selftests/vm/pkey-powerpc.h
>  create mode 100644 tools/testing/selftests/vm/pkey-x86.h
>  rename tools/testing/selftests/{x86 => vm}/protection_keys.c (74%)
>  delete mode 100644 tools/testing/selftests/x86/pkey-helpers.h
>
> -- 
> 2.17.1

-aneesh
