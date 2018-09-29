From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH security-next v3 00/29] LSM: Explict LSM ordering
Date: Sat, 29 Sep 2018 19:48:23 +0900
Message-ID: <eda428eb-f6e1-f048-a394-251953c388b6@i-love.sakura.ne.jp>
References: <20180925001832.18322-1-keescook@chromium.org>
 <e6122c7d-bd29-d081-3c1e-96b7c369d4fe@schaufler-ca.com>
 <CAGXu5jKQVDW8Wp0ESv2raa0xJnHCCMNqFCzZ5jSVXQ=Dp7FF8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGXu5jKQVDW8Wp0ESv2raa0xJnHCCMNqFCzZ5jSVXQ=Dp7FF8A@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>, John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 2018/09/29 5:01, Kees Cook wrote:
> On Fri, Sep 28, 2018 at 8:55 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/24/2018 5:18 PM, Kees Cook wrote:
>>> v3:
>>> - add CONFIG_LSM_ENABLE and refactor resulting logic
>>
>> Kees, you can add my
>>
>>         Reviewed-by:Casey Schaufler <casey@schaufler-ca.com>
>>
>> for this entire patch set. Thank you for taking this on, it's
>> a significant and important chunk of the LSM infrastructure
>> update.
> 
> Thanks!
> 
> John, you'd looked at this a bit too -- do the results line up with
> your expectations?
> 
> Any thoughts from SELinux, TOMOYO, or IMA folks?

I'm OK with this approach. Thank you.



Just wondering what is "__lsm_name_##lsm" for...

+#define DEFINE_LSM(lsm)                                                        \
+       static const char __lsm_name_##lsm[] __initconst                \
+               __aligned(1) = #lsm;                                    \
+       static struct lsm_info __lsm_##lsm                              \
+               __used __section(.lsm_info.init)                        \
+               __aligned(sizeof(unsigned long))                        \
+               = {                                                     \
+                       .name = __lsm_name_##lsm,                       \
+
+#define END_LSM          }

We could do something like below so that funny END_LSM is not required?
I felt } like a typo error at the first glance. What we need is to
gather into one section with appropriate alignment, isn't it?

#define LSM_INFO                                                        \
	static struct lsm_info __lsm_                                   \
		__used __section(.lsm_info.init)                        \
		__aligned(sizeof(unsigned long))                        \

LSM_INFO = {
	.name = "tomoyo",
	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
	.init = tomoyo_init,
};
