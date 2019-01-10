From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v3 02/24] kernel: Define gettimeofday vdso common code
Date: Thu, 10 Jan 2019 10:36:12 +0000
Message-ID: <e2156e71-a167-ce03-650f-9093d5cd4330@arm.com>
References: <20181213165746.56930-1-vincenzo.frascino@arm.com>
 <20181213165746.56930-3-vincenzo.frascino@arm.com>
 <51d9b642-d44e-1995-0bd0-91ce00a8526b@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51d9b642-d44e-1995-0bd0-91ce00a8526b@android.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Salyzyn <salyzyn@android.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
List-Id: linux-arch.vger.kernel.org

On 14/12/2018 18:15, Mark Salyzyn wrote:
> On 12/13/2018 08:57 AM, Vincenzo Frascino wrote:
>> In the last few years we assisted to an explosion of vdso
>> implementations that mostly share similar code.
>>
>> . . .
>> +}
>> +
>> +#ifdef VDSO_HAS_TIME
>> +static notrace time_t __cvdso_time(time_t *time)
>> +{
>> +	u32 seq;
>> +	time_t t;
>> +	const struct vdso_data *vd = __arch_get_vdso_data();
>> +	struct vdso_timestamp *vdso_ts = &vd->basetime[CLOCK_REALTIME];
> const struct vdso_timestamp *vdso_ts = &vd->basetime[CLOCK_REALTIME];
>

Thanks for this, I will fix in v4.

> -- Mark
> 

-- 
Regards,
Vincenzo
