From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v15 06/23] selftests/vm/pkeys: Typecast the pkey register
Date: Thu, 19 Dec 2019 22:39:44 +1100
Message-ID: <87d0ckmtmn.fsf@mpe.ellerman.id.au>
References: <cover.1576645161.git.sandipan@linux.ibm.com>
 <719ec65756a64cc03e8464a9c6da51c4519d2389.1576645161.git.sandipan@linux.ibm.com>
 <5b6c3f8a-9d2f-2534-c072-89f130ce110f@intel.com>
 <20191218205905.GG4113@kitsune.suse.cz>
 <15c3b6cc-d8da-9a32-da6a-4c3990f48994@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <15c3b6cc-d8da-9a32-da6a-4c3990f48994@intel.com>
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
To: Dave Hansen <dave.hansen@intel.com>, Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, aneesh.kumar@linux.ibm.com, x86@kernel.org, linuxram@us.ibm.com, shuahkh@osg.samsung.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, Sandipan Das <sandipan@linux.ibm.com>, linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, bauerman@linux.ibm.com
List-Id: linux-arch.vger.kernel.org

Dave Hansen <dave.hansen@intel.com> writes:
> On 12/18/19 12:59 PM, Michal Such=C3=A1nek wrote:
>>> I'd really just rather do %016lx *everywhere* than sprinkle the
>>> PKEY_REG_FMTs around.
>> Does lx work with u32 without warnings?
>
> Either way, I'd be happy to just make the x86 one u64 to make the whole
> thing look more sane,

It's userspace so you don't get u64, you only get __u64.

And then you'll hit the fact that by default __u64 is unsigned long on
powerpc and unsigned long long on x86, meaning you still can't use the
same printf specifier.

To avoid that you should define __SANE_USERSPACE_TYPES__ before
including any headers, and then you'll get unsigned long long for __u64
everywhere and you can just use %llx.

cheers
