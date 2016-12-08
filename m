From: Florian Weimer <fweimer@redhat.com>
Subject: Re: [Question] New mmap64 syscall?
Date: Thu, 8 Dec 2016 16:47:34 +0100
Message-ID: <14981df2-b120-17c3-a5a8-5cbbd2008c4f@redhat.com>
References: <20161206185440.GA4654@yury-N73SV>
 <f544bcc3-8aae-1bd0-b744-9964fc038a51@redhat.com>
 <20161207154811.GA15248@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <libc-alpha-return-75650-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
In-Reply-To: <20161207154811.GA15248@yury-N73SV>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: libc-alpha@sourceware.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, zhouchengming1@huawei.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, arnd@arndb.de, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, linux-arm-kernel@lists.infradead.org, maxim.kuvyrkov@linaro.org, Nathan_Lynch@mentor.com, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org

On 12/07/2016 04:48 PM, Yury Norov wrote:
> On Wed, Dec 07, 2016 at 02:23:55PM +0100, Florian Weimer wrote:
>> On 12/06/2016 07:54 PM, Yury Norov wrote:
>>> 3. Introduce new mmap64() syscall like this:
>>> sys_mmap64(void *addr, size_t len, int prot, int flags, int fd, struct off_pair *off);
>>> (The pointer here because otherwise we have 7 args, if simply pass off_hi and
>>> off_lo in registers.)
>>
>> I would prefer a batched mmap/munmap/mremap/mprotect/madvise interface, so
>> that VM changes can be coalesced and the output reduced.  This interface
>> could then be used to implement mmap on 32-bit architectures as well because
>> the offset restrictions would not apply there.
>
> Hi Florian,
>
> I frankly don't understand what you mean, All syscalls you mentioned
> doesn't take off_t or other 64-bit arguments. 'VM changes' - virtual
> memory? If so, I don't see any changes in VM with this approach, just
> correct handling of big offsets.

What I was trying to suggest is a completely different interface which 
is not subject to register size constraints and which has been requested 
before (a mechanism for batching mm updates).

Thanks,
Florian
