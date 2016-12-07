From: Florian Weimer <fweimer@redhat.com>
Subject: Re: [Question] New mmap64 syscall?
Date: Wed, 7 Dec 2016 14:23:55 +0100
Message-ID: <f544bcc3-8aae-1bd0-b744-9964fc038a51@redhat.com>
References: <20161206185440.GA4654@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161206185440.GA4654@yury-N73SV>
Sender: linux-kernel-owner@vger.kernel.org
To: Yury Norov <ynorov@caviumnetworks.com>, libc-alpha@sourceware.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, zhouchengming1@huawei.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, arnd@arndb.de, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, linux-arm-kernel@lists.infradead.org, maxim.kuvyrkov@linaro.org, Nathan_Lynch@mentor.com, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org

On 12/06/2016 07:54 PM, Yury Norov wrote:
> 3. Introduce new mmap64() syscall like this:
> sys_mmap64(void *addr, size_t len, int prot, int flags, int fd, struct off_pair *off);
> (The pointer here because otherwise we have 7 args, if simply pass off_hi and
> off_lo in registers.)

I would prefer a batched mmap/munmap/mremap/mprotect/madvise interface, 
so that VM changes can be coalesced and the output reduced.  This 
interface could then be used to implement mmap on 32-bit architectures 
as well because the offset restrictions would not apply there.

Thanks,
Florian
