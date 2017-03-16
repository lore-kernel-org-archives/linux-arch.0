From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] generic syscalls: Wire up statx syscall
Date: Thu, 16 Mar 2017 10:48:11 +0100
Message-ID: <CAK8P3a3YPsa_FXvqAmt2rQqRPc+Rby6n_+5MoMR2EV85jQHyjQ@mail.gmail.com>
References: <20170313144521.28127-1-shorne@gmail.com>
 <CAAG0J99QAwefvpnNxrGRU6XH+0+k1LO6qRW3kLBQCc3nc6QdmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAAG0J99QAwefvpnNxrGRU6XH+0+k1LO6qRW3kLBQCc3nc6QdmA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 15, 2017 at 11:26 PM, James Hogan <james.hogan@imgtec.com> wrote:
> On 13 March 2017 at 14:45, Stafford Horne <shorne@gmail.com> wrote:

>>  #undef __NR_syscalls
>> -#define __NR_syscalls 291
>> +#define __NR_syscalls 292
>
> Out of interest, anybody know OTOH which other stat syscalls statx
> supersedes (such that they could at some point be disabled by default
> in asm-generic for new arches, and implemented in userspace)?

It should replace the entire stat family {old,new,}{f,}stat{at,}{64,}, but not
the {f,}statfs{64,} family, which will eventually get another replacement.

      Arnd
