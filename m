From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH security-next v4 10/32] LSM: Don't ignore initialization failures
Date: Tue, 2 Oct 2018 14:38:05 -0700
Message-ID: <CAGXu5jJRFv_e7_-hAnuuEoC90JPXG2aTaHJ98_UaoS_4R1mYtg@mail.gmail.com>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-11-keescook@chromium.org>
 <alpine.LRH.2.21.1810030719040.23596@namei.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LRH.2.21.1810030719040.23596@namei.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 2, 2018 at 2:20 PM, James Morris <jmorris@namei.org> wrote:
> On Mon, 1 Oct 2018, Kees Cook wrote:
>
>> LSM initialization failures have traditionally been ignored. We should
>> at least WARN when something goes wrong.
>
> I guess we could have a boot param which specifies what to do if any LSM
> fails to init, as I think some folks will want to stop execution at that
> point.
>
> Thoughts?

I'm not opposed, but I won't author it because Linus will yell at me
about introducing a "machine killing" option.

-Kees

-- 
Kees Cook
Pixel Security
