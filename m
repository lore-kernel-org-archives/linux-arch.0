From: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Subject: Re: ILP32 for ARM64: testing with glibc testsuite
Date: Mon, 5 Dec 2016 18:24:11 +0800
Message-ID: <d4dedc32-b324-107d-7de1-d1e670ffc00a@huawei.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <20161107082359.GA19666@yury-N73SV> <20161109095650.GA22804@yury-N73SV>
 <CC4F99A7-1FD2-486A-BD66-ED06F1B8BF50@linaro.org>
 <1479419136.908.90.camel@caviumnetworks.com>
 <ff3b973b-3887-7ae8-5a27-4d1ad115055f@huawei.com>
 <mvmeg1mn0yp.fsf@hawking.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <libc-alpha-return-75458-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
In-Reply-To: <mvmeg1mn0yp.fsf@hawking.suse.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Steve Ellcey <sellcey@caviumnetworks.com>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Yury Norov <ynorov@caviumnetworks.com>, arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, GNU C Library <libc-alpha@sourceware.org>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Andrew Pinski <pinskia@gmail.com>, broonie@kernel.org, "Joseph S. Myers" <joseph@codesourcery.com>, christoph.muellner@theobroma-systems.com, Szabolcs Nagy <szabolcs.nagy@arm.com>, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, kilobyte@angband.pl, Geert Uytterhoeven <geert@linux-m68k.org>, Dr.
 Phil
List-Id: linux-arch.vger.kernel.org



On 2016/12/5 18:07, Andreas Schwab wrote:
> On Dez 05 2016, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com> wrote:
>
>> Is there some progresses on it? We could collabrate to fix those issues.
>
> All the elf/nptl/rt fails should be fixed by the recent binutils fixes.
Cool. How about the conform and other failures?

Regards

Bamvor
>
> Andreas.
>
