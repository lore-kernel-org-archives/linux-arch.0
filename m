From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [Question] New mmap64 syscall?
Date: Wed, 7 Dec 2016 21:18:11 +0530
Message-ID: <20161207154811.GA15248@yury-N73SV>
References: <20161206185440.GA4654@yury-N73SV>
 <f544bcc3-8aae-1bd0-b744-9964fc038a51@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <f544bcc3-8aae-1bd0-b744-9964fc038a51@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Florian Weimer <fweimer@redhat.com>
Cc: szabolcs.nagy@arm.com, Catalin Marinas <catalin.marinas@arm.com>, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, linux-arch@vger.kernel.org, zhouchengming1@huawei.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, arnd@arndb.de, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, linux-arm-kernel@lists.infradead.org, maxim.kuvyrkov@linaro.org, libc-alpha@sourceware.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org

On Wed, Dec 07, 2016 at 02:23:55PM +0100, Florian Weimer wrote:
> On 12/06/2016 07:54 PM, Yury Norov wrote:
> >3. Introduce new mmap64() syscall like this:
> >sys_mmap64(void *addr, size_t len, int prot, int flags, int fd, struct off_pair *off);
> >(The pointer here because otherwise we have 7 args, if simply pass off_hi and
> >off_lo in registers.)
> 
> I would prefer a batched mmap/munmap/mremap/mprotect/madvise interface, so
> that VM changes can be coalesced and the output reduced.  This interface
> could then be used to implement mmap on 32-bit architectures as well because
> the offset restrictions would not apply there.

Hi Florian,

I frankly don't understand what you mean, All syscalls you mentioned
doesn't take off_t or other 64-bit arguments. 'VM changes' - virtual
memory? If so, I don't see any changes in VM with this approach, just
correct handling of big offsets.

> This interface
> could then be used to implement mmap on 32-bit architectures as well 

This is for 32-bit architectures only. 64 bit arches use
sysdeps/unix/sysv/linux/wordsize-64/mmap.c for both mmap and mmap64,
and they don't need that tricks with off_t. Or you meaning to switch
64-bit mmap to this interface?

Please explain what you mean in details.

Yury
