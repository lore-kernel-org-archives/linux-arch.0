From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 10/73] powerpc: use device_initcall for registering rtc
 devices
Date: Tue, 21 Jan 2014 21:26:52 -0500
Message-ID: <CAP=VYLp5UiVJYxtpAcptoqdvgYD_Z=5CMBxmKekXEeSSBgFS9Q@mail.gmail.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
 <1390339396-3479-11-git-send-email-paul.gortmaker@windriver.com>
 <1390348085.5027.18.camel@smoke>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1390348085.5027.18.camel@smoke>
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
To: Geoff Levand <geoff@infradead.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 21, 2014 at 6:48 PM, Geoff Levand <geoff@infradead.org> wrote:
> Hi Paul,
>
> On Tue, 2014-01-21 at 16:22 -0500, Paul Gortmaker wrote:
>> Currently these two RTC devices are in core platform code
>> where it is not possible for them to be modular.  It will
>> never be modular, so using module_init as an alias for
>> __initcall can be somewhat misleading.
>>
>>  arch/powerpc/kernel/time.c        | 2 +-
>>  arch/powerpc/platforms/ps3/time.c | 3 +--
>>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> I tested the PS3 part of this patch and it seems to work OK.
>
> Acked-by: Geoff Levand <geoff@infradead.org>

Thanks Geoff for the review and testing; I'll add the ack.

Paul.
--

>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
