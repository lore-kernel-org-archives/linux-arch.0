Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:47493 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932373AbWCTRab (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 20 Mar 2006 12:30:31 -0500
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id k2KHUT230088
	for <linux-arch@vger.kernel.org>; Mon, 20 Mar 2006 12:30:29 -0500
Subject: Re: [PATCH] add flush_kernel_dcache_page() API
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <1142873981.3283.33.camel@mulgrave.il.steeleye.com>
References: <1142873981.3283.33.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 11:30:28 -0600
Message-Id: <1142875828.3283.43.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2006-03-20 at 10:59 -0600, James Bottomley wrote:
> We have a problem with a lot of emulated storage in that the driver takes a page
> from get_user_pages() and does something like

If you'd like to test whether your arch may have this problem (and the
prior flush_anon_page() problem), try this attached patch.  If you
compile it as a module and insert it, it produces a

/proc/fs/test

file

if you cat /proc/fs/test, you should see 'Hello!' and anything you echo
to /proc/fs/test should be echo'd via a printk.

if you do this many times and don't always see the text, then you
probably need to implement these APIs in your arch.

The code is a modification of a fuse test case, so I didn't write it ...

James

#include <linux/fs.h>
#include <linux/module.h>
#include <linux/proc_fs.h>
#include <linux/pagemap.h>
#include <asm/uaccess.h>

MODULE_LICENSE("GPL");

static int my_copy_to_user1(char __user *dst, const char *src, size_t size)
{
    return copy_to_user(dst, src, size) ? -EFAULT : 0;
}

static int my_copy_from_user1(char *dst, const char __user *src, size_t size)
{
    return copy_from_user(dst, src, size) ? -EFAULT : 0;
}

static int my_copy_to_user2(char __user *dst, const char *src, size_t size)
{
    int err;
    struct page *page;
    unsigned long addr = (unsigned long) dst;
    unsigned offset = addr % PAGE_SIZE;
    void *mapaddr;
    void *ptr;
    if (offset + size > PAGE_SIZE)
        return -EINVAL;

    down_read(&current->mm->mmap_sem);
    err = get_user_pages(current, current->mm, addr, 1, 1, 0, &page, NULL);
    up_read(&current->mm->mmap_sem);
    if (err < 0)
        return err;
    //__asm__ __volatile("\tfdc\t0(%%sr3, %0)\n" : : "r" (addr) : "memory");
    BUG_ON(err != 1);
    mapaddr = kmap_atomic(page, KM_USER0);
    ptr = mapaddr + offset;

    printk("dst: %p page: %p offset: %u mapaddr: %p ptr: %p\n",
           dst, page, offset, mapaddr, ptr);
    printk("mapping %p mapping_mapped %d\n", page->mapping,
	   page->mapping ? mapping_mapped(page->mapping): 0);

    memcpy(ptr, src, size);

    flush_kernel_dcache_page(mapaddr);
    kunmap_atomic(mapaddr, KM_USER0);

    set_page_dirty_lock(page);
    page_cache_release(page);

    return 0;
}

static int my_copy_from_user2(char *dst, const char __user *src, size_t size)
{
    int err;
    struct page *page;
    unsigned long addr = (unsigned long) src;
    unsigned offset = addr % PAGE_SIZE;
    void *mapaddr;
    void *ptr;
    if (offset + size > PAGE_SIZE)
        return -EINVAL;

    down_read(&current->mm->mmap_sem);
    err = get_user_pages(current, current->mm, addr, 1, 0, 0, &page, NULL);
    up_read(&current->mm->mmap_sem);
    if (err < 0)
        return err;
    BUG_ON(err != 1);
    mapaddr = kmap_atomic(page, KM_USER0);
    ptr = mapaddr + offset;

    printk("src: %p page: %p offset: %u mapaddr: %p ptr: %p\n",
           src, page, offset, mapaddr, ptr);

    memcpy(dst, ptr, size);

    kunmap_atomic(mapaddr, KM_USER0);
    put_page(page);

    return 0;
}


static ssize_t test_read(struct file *file, char __user *buf, size_t nbytes,
                         loff_t *off)
{
    ssize_t res = 0;
    char hello[] = "Hello!\n";
    size_t hellolen = strlen(hello);
    printk("test_read %p %lu %llu\n", buf, (unsigned long) nbytes,
           (unsigned long long) *off);
    if (!*off && nbytes > hellolen) {
        res = my_copy_to_user2(buf, hello, hellolen);
        if (!res) {
            *off += hellolen;
            res = hellolen;
        }
    }
    printk("  test_read: %li\n", (long) res);
    return res;
}

static ssize_t test_write(struct file *file, const char __user *buf,
                          size_t nbytes, loff_t *off)
{
    ssize_t res = nbytes;
    char hello[32];
    printk("test_write %p %lu %llu\n", buf, (unsigned long) nbytes,
           (unsigned long long) *off);
    if (!*off && nbytes < sizeof(hello) - 1) {
        res = my_copy_from_user2(hello, buf, nbytes);
        if (!res) {
            hello[nbytes] = '\0';
            printk("<%s>\n", hello);
            *off += nbytes;
            res = nbytes;
        }
    }
    printk("  test_write: %li\n", (long) res);
    return res;
}

static struct file_operations test_ops = {
	.owner		= THIS_MODULE,
	.read		= test_read,
	.write		= test_write,
};

static int test_init(void)
{
    struct proc_dir_entry *ent;
    ent = create_proc_entry("test", S_IFREG | 0666, proc_root_fs);
    if (ent)
        ent->proc_fops = &test_ops;
    return 0;
}

static void test_exit(void)
{
    remove_proc_entry("test", proc_root_fs);
}

module_init(test_init);
module_exit(test_exit);


