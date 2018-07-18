From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v14 20/22] selftests/vm: testcases must restore
 pkey-permissions
Date: Wed, 18 Jul 2018 09:56:49 -0700
Message-ID: <ea9c3220-c4dd-124a-2031-eaca6859b389@intel.com>
References: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
 <1531835365-32387-21-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1531835365-32387-21-git-send-email-linuxram@us.ibm.com>
Content-Language: en-US
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
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, x86@kernel.org, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com, msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On 07/17/2018 06:49 AM, Ram Pai wrote:
> Generally the signal handler restores the state of the pkey register
> before returning. However there are times when the read/write operation
> can legitamely fail without invoking the signal handler.  Eg: A
> sys_read() operaton to a write-protected page should be disallowed.  In
> such a case the state of the pkey register is not restored to its
> original state.  Test cases may not remember to restoring the key
> register state. During cleanup generically restore the key permissions.

This would, indeed be a good thing to do for a well-behaved application.

But, for selftests, why does it matter what state we leave the key in?
Doesn't the test itself need to establish permissions?  Don't we *do*
that at pkey_alloc() anyway?

What problem does this solve?

> diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> index 8a6afdd..ea3cf04 100644
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -1476,8 +1476,13 @@ void run_tests_once(void)
>  		pkey_tests[test_nr](ptr, pkey);
>  		dprintf1("freeing test memory: %p\n", ptr);
>  		free_pkey_malloc(ptr);
> +
> +		/* restore the permission on the key after use */
> +		pkey_access_allow(pkey);
> +		pkey_write_allow(pkey);
>  		sys_pkey_free(pkey);
>  
> +
>  		dprintf1("pkey_faults: %d\n", pkey_faults);
>  		dprintf1("orig_pkey_faults: %d\n", orig_pkey_faults);
