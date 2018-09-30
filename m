From: Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 0/3] namei: implement various scoping AT_* flags
Date: Sun, 30 Sep 2018 16:02:10 +0200
Message-ID: <58BB23FF-E652-4C58-AEE4-4B5376D03BF0@brauner.io>
References: <20180929103453.12025-1-cyphar@cyphar.com> <CADZs7q5mFGMvtbAHzjKdC8b7byz8pvBOaLBOTxnXRwTZ1LfCAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADZs7q5mFGMvtbAHzjKdC8b7byz8pvBOaLBOTxnXRwTZ1LfCAw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alban Crequy <alban@kinvolk.io>, cyphar@cyphar.com
Cc: jlayton@kernel.org, bfields@fieldses.org, Alexander Viro <viro@zeniv.linux.org.uk>, arnd@arndb.de, shuah@kernel.org, dhowells@redhat.com, luto@kernel.org, "Eric W . Biederman" <ebiederm@xmission.com>, tycho@tycho.ws, LKML <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, dev <dev@opencontainers.org>, Linux Containers <containers@lists.linux-foundation.org>, jsafrane@redhat.com, msau@google.com
List-Id: linux-arch.vger.kernel.org

On September 30, 2018 3:54:31 PM GMT+02:00, Alban Crequy <alban@kinvolk=2Ei=
o> wrote:
>On Sat, Sep 29, 2018 at 12:35 PM Aleksa Sarai <cyphar@cyphar=2Ecom>
>wrote:
>>
>> The need for some sort of control over VFS's path resolution (to
>avoid
>> malicious paths resulting in inadvertent breakouts) has been a very
>> long-standing desire of many userspace applications=2E This patchset is
>a
>> revival of Al Viro's old AT_NO_JUMPS[1] patchset with a few
>additions=2E
>>
>> The most obvious change is that AT_NO_JUMPS has been split as
>dicussed
>> in the original thread, along with a further split of AT_NO_PROCLINKS
>> which means that each individual property of AT_NO_JUMPS is now a
>> separate flag:
>>
>>   * Path-based escapes from the starting-point using "/" or "=2E=2E" ar=
e
>>     blocked by AT_BENEATH=2E
>>   * Mountpoint crossings are blocked by AT_XDEV=2E
>>   * /proc/$pid/fd/$fd resolution is blocked by AT_NO_PROCLINKS (more
>>         correctly it actually blocks any user of nd_jump_link()
>because it
>>         allows out-of-VFS path resolution manipulation)=2E
>>
>> AT_NO_JUMPS is now effectively (AT_BENEATH|AT_XDEV|AT_NO_PROCLINKS)=2E
>At
>> Linus' suggestion in the original thread, I've also implemented
>> AT_NO_SYMLINKS which just denies _all_ symlink resolution (including
>> "proclink" resolution)=2E
>
>It seems quite useful to me=2E
>
>> An additional improvement was made to AT_XDEV=2E The original
>AT_NO_JUMPS
>> path didn't consider "/tmp/=2E=2E" as a mountpoint crossing -- this pat=
ch
>> blocks this as well (feel free to ask me to remove it if you feel
>this
>> is not sane)=2E
>>
>> Currently I've only enabled these for openat(2) and the stat(2)
>family=2E
>> I would hope we could enable it for basically every *at(2) syscall --
>> but many of them appear to not have a @flags argument and thus we'll
>> need to add several new syscalls to do this=2E I'm more than happy to
>send
>> those patches, but I'd prefer to know that this preliminary work is
>> acceptable before doing a bunch of copy-paste to add new sets of
>*at(2)
>> syscalls=2E
>
>What do you think of an equivalent feature AT_NO_SYMLINKS flag for
>mount()?

That's something we discussed  but that would need to be part of the new m=
ount API work by David=2E The current mount API doesn't take AT_* flags sin=
ce it doesn't operate on fds and we're (sort of) out of mount flags=2E

>
>I guess that would have made the fix for CVE-2017-1002101 in
>Kubernetes easier to write:
>https://kubernetes=2Eio/blog/2018/04/04/fixing-subpath-volume-vulnerabili=
ty/
>
>> One additional feature I've implemented is AT_THIS_ROOT (I imagine
>this
>> is probably going to be more contentious than the refresh of
>> AT_NO_JUMPS, so I've included it in a separate patch)=2E The patch
>itself
>> describes my reasoning, but the shortened version of the premise is
>that
>> continer runtimes need to have a way to resolve paths within a
>> potentially malicious rootfs=2E Container runtimes currently do this in
>> userspace[2] which has implicit race conditions that are not
>resolvable
>> in userspace (or use fork+exec+chroot and SCM_RIGHTS passing which is
>> inefficient)=2E AT_THIS_ROOT allows for per-call chroot-like semantics
>for
>> path resolution, which would be invaluable for us -- and the
>> implementation is basically identical to AT_BENEATH (except that we
>> don't return errors when someone actually hits the root)=2E
>>
>> I've added some selftests for this, but it's not clear to me whether
>> they should live here or in xfstests (as far as I can tell there are
>no
>> other VFS tests in selftests, while there are some tests that look
>like
>> generic VFS tests in xfstests)=2E If you'd prefer them to be included
>in
>> xfstests, let me know=2E
>>
>> [1]: https://lore=2Ekernel=2Eorg/patchwork/patch/784221/
>> [2]: https://github=2Ecom/cyphar/filepath-securejoin
>>
>> Aleksa Sarai (3):
>>   namei: implement O_BENEATH-style AT_* flags
>>   namei: implement AT_THIS_ROOT chroot-like path resolution
>>   selftests: vfs: add AT_* path resolution tests
>>
>>  fs/fcntl=2Ec                                    |   2 +-
>>  fs/namei=2Ec                                    | 158
>++++++++++++------
>>  fs/open=2Ec                                     |  10 ++
>>  fs/stat=2Ec                                     |  15 +-
>>  include/linux/fcntl=2Eh                         |   3 +-
>>  include/linux/namei=2Eh                         |   8 +
>>  include/uapi/asm-generic/fcntl=2Eh              |  20 +++
>>  include/uapi/linux/fcntl=2Eh                    |  10 ++
>>  tools/testing/selftests/Makefile              |   1 +
>>  tools/testing/selftests/vfs/=2Egitignore        |   1 +
>>  tools/testing/selftests/vfs/Makefile          |  13 ++
>>  tools/testing/selftests/vfs/at_flags=2Eh        |  40 +++++
>>  tools/testing/selftests/vfs/common=2Esh         |  37 ++++
>>  =2E=2E=2E/selftests/vfs/tests/0001_at_beneath=2Esh    |  72 ++++++++
>>  =2E=2E=2E/selftests/vfs/tests/0002_at_xdev=2Esh       |  54 ++++++
>>  =2E=2E=2E/vfs/tests/0003_at_no_proclinks=2Esh         |  50 ++++++
>>  =2E=2E=2E/vfs/tests/0004_at_no_symlinks=2Esh          |  49 ++++++
>>  =2E=2E=2E/selftests/vfs/tests/0005_at_this_root=2Esh  |  66 ++++++++
>>  tools/testing/selftests/vfs/vfs_helper=2Ec      | 154
>+++++++++++++++++
>>  19 files changed, 707 insertions(+), 56 deletions(-)
>>  create mode 100644 tools/testing/selftests/vfs/=2Egitignore
>>  create mode 100644 tools/testing/selftests/vfs/Makefile
>>  create mode 100644 tools/testing/selftests/vfs/at_flags=2Eh
>>  create mode 100644 tools/testing/selftests/vfs/common=2Esh
>>  create mode 100755
>tools/testing/selftests/vfs/tests/0001_at_beneath=2Esh
>>  create mode 100755 tools/testing/selftests/vfs/tests/0002_at_xdev=2Esh
>>  create mode 100755
>tools/testing/selftests/vfs/tests/0003_at_no_proclinks=2Esh
>>  create mode 100755
>tools/testing/selftests/vfs/tests/0004_at_no_symlinks=2Esh
>>  create mode 100755
>tools/testing/selftests/vfs/tests/0005_at_this_root=2Esh
>>  create mode 100644 tools/testing/selftests/vfs/vfs_helper=2Ec
>>
>> --
>> 2=2E19=2E0
