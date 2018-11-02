From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH security-next v5 12/30] LSM: Provide separate ordered initialization
Date: Fri, 2 Nov 2018 13:49:09 -0700
Message-ID: <CAGXu5jKM_goC2519EXZu7Bh0VoW8jQeR=AJ0XovUPe4_635XNw@mail.gmail.com>
References: <20181011001846.30964-1-keescook@chromium.org> <20181011001846.30964-13-keescook@chromium.org>
 <1541182406.20901.31.camel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541182406.20901.31.camel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, Jordan Glover <Golden_Miller83@protonmail.ch>, LSM <linux-security-module@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Nov 2, 2018 at 11:13 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> I don't recall why "integrity" is on the security_initcall, while both
> IMA and EVM are on the late_initcall().

It's because integrity needs to have a VFS buffer allocated extremely
early, so it used the security init to do it. While it's not an LSM,
it does use this part of LSM infrastructure. I didn't see an obvious
alternative at the time, but now that I think about it, maybe just a
simple postcore_initcall() would work?

-Kees

-- 
Kees Cook
