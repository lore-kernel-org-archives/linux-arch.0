From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v14 07/22] selftests/vm: generic function to handle shadow
 key register
Date: Wed, 18 Jul 2018 08:34:37 -0700
Message-ID: <ed8baf0c-7ccf-aa99-a88b-9b7697af89f4@intel.com>
References: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
 <1531835365-32387-8-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1531835365-32387-8-git-send-email-linuxram@us.ibm.com>
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
> -	shifted_pkey_reg = (pkey_reg >> (pkey * PKEY_BITS_PER_PKEY));
> +	shifted_pkey_reg = right_shift_bits(pkey, pkey_reg);
>  	dprintf2("%s() shifted_pkey_reg: "PKEY_REG_FMT"\n", __func__,
>  			shifted_pkey_reg);
>  	masked_pkey_reg = shifted_pkey_reg & mask;

I'm not a fan of how this looks.  This is almost certainly going to get
the argument order mixed up at some point.

Why do we need this?  The description doesn't say.
