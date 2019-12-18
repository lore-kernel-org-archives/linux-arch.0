From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v15 00/24] selftests, powerpc, x86: Memory Protection Keys
Date: Wed, 18 Dec 2019 12:48:11 -0800
Message-ID: <ab2d5c1f-3103-78e3-6c5d-990494ee3580@intel.com>
References: <cover.1576645161.git.sandipan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <cover.1576645161.git.sandipan@linux.ibm.com>
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
To: Sandipan Das <sandipan@linux.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, aneesh.kumar@linux.ibm.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org, bauerman@linux.ibm.com
List-Id: linux-arch.vger.kernel.org

On 12/17/19 11:51 PM, Sandipan Das wrote:
> Testing
> -------
> Verified for correctness on powerpc. Need help with x86 testing as I
> do not have access to a Skylake server. Client platforms like Coffee
> Lake do not have the required feature bits set in CPUID.

FWIW, you can get a Skylake Server instance from cloud providers.  I
spooled up an Amazon EC3 instance once to run these tests.  It think it
cost me $0.08.
